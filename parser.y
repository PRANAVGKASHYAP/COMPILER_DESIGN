
%{

    #include "sym_tab.c"
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    int yylex();
    void yyerror(char *s);
    extern int yylineno;
    #define YYSTYPE char*
    int type=-1;	//initial declaration of type for symbol table
	int vtype=-1;	//initial declaration for type checking for symbol table
	int scope=0;	//initial declaration for scope

%}

%token INCLUDE INT FLOAT DOUBLE CHAR MAIN NUM IF WHILE DO FOR SWITCH CASE BREAK DEFAULT GTE LTE NEQ EQ RETURN STRING ID

%%

start : Prog  | S { printf("Valid Declaration\n"); YYACCEPT; } ;

Prog : head mainFnc ;

head : '#' INCLUDE '<' STRING '>' head  | ;

mainFnc : INT MAIN '(' ')' '{' {scope++;}  S '}' {scope--;} | ;

S : Dclr ';' S
    | if_st S
    | while_st S 
    | do_while_st S 
    | for_st S 
    | switch_st S 
    | Arrays ';' S 
    | return_st;
    | Assign ';' S 
    |
    ;

Dclr : Type List ;

Type : INT {type = INT_DT ; }
    | FLOAT {type = FLOAT_DT ; }
    | DOUBLE {type = DOUBLE_DT ; }
    | CHAR {type = CHAR_DT ; }
    ;

List : List ',' VAR
    | VAR
    ;

VAR: ID '=' E 	{
        if(check_sym_tab($1))
        {
            printf("variable %s declared",$1);
            yyerror($1);
        }

        else
        {
            insert_symbol($1 , size(type) , type , yylineno , scope);
            insert_val($1 , $3 , yylineno);
        }
    }

     | ID 	{
		if(check_sym_tab($1))
		{
			printf("variable %s declared",$1);
			yyerror($1);
		}

		else
		{
			insert_symbol($1 , size(type) , type , yylineno , scope);
		}
	} ;


Assign :  ID '=' E {
        if(check_sym_tab($1))
        {
            insert_val($1 , $3 , yylineno);
        }

        else
        {
            
            printf("variable %s not declared",$1);
            yyerror($1);
        }
    } ;



E : E '+' T
{
    if(vtype == 2){ sprintf($$ , "%d" , ( atoi($1) + atoi($3) ) ) ; } 
	else if(vtype == 3){ sprintf($$ , "%f" , ( atof($1) + atof($3) ) ) ; } 
	else printf("charecter used in arith operation \n");
	yyerror($$);
}
    | E '-' T
{
    if(vtype == 2){ sprintf($$ , "%d" , ( atoi($1) - atoi($3) ) )  ; } 
	else if(vtype == 3){ sprintf($$ , "%f" , ( atof($1) - atof($3) ) ) ; } 
	else printf("charecter used in arith operation \n");
	yyerror($$);
}
    | T 
    ;

T : T '*' F
{
    if(vtype == 2){ sprintf($$ , "%d" , ( atoi($1) * atoi($3) ) ) ;  } 
	else if(vtype == 3){ sprintf($$ , "%f" , ( atof($1) * atof($3) ) )  ; } 
	else printf("charecter used in arith operation \n");
	yyerror($$);
}
    | T '/' F
{
    if(vtype == 2){ sprintf($$ , "%d" , ( atoi($1) / atoi($3) ) ) ; } 
	else if(vtype == 3){ sprintf($$ , "%f" , ( atof($1) / atof($3) ) ) ; } 
	else printf("charecter used in arith operation \n");
	yyerror($$);
}
    | F 
    ;

F : ID
{
    if(check_sym_tab($1))
		{
			char* value = retrieve_val($1);
			
			if(value == "~")
			{
				printf("variable %s not initialized\n" , $1);
				yyerror($1);
			}

			else
			{
				$$ = strdup($1);
				vtype = type_check(value);
			}
		}
}
    | NUM
{
    $$ = strdup($1);
    vtype = type_check($1);
}
    | '(' E ')' 
    ;

if_st : IF '(' cond ')' '{' S {scope++ ; } '}' {scope--;} ;

cond : E RELOP E ;

RELOP : '>'
    | '<'
    | GTE
    | LTE
    | EQ
    | NEQ 
    ;

while_st : WHILE '(' cond ')' '{' S {scope++ ; } '}' {scope-- ; } ;

do_while_st : DO '{' S {scope++ ; } '}' {scope-- ; } WHILE '(' cond ')' ;

for_st : FOR '(' For_type  Assign ';' cond ';' iter_st ')'  '{' S {scope++ ; } '}' {scope-- ; } ;

For_type : Type | ;

iter_st : '+' '+' ID
    | '-' '-' ID 
    | ID '+' '+'
    | ID '-' '-' 
    ;

switch_st : SWITCH '(' ID ')' '{' body {scope++ ; } '}' {scope-- ; } ;

body : CASE NUM ':' E ';' BREAK ';' body default_st
    |  ;

default_st : DEFAULT ':' E ';' | ;

Arrays : Type ID dim ;

dim : '[' NUM ']' dim | ;

return_st : RETURN E ';' ;

%%

void yyerror(char *s)
{
    printf("%s\n", s);
    printf("error is in line number : %d \n " , yylineno);
    exit(0);
}

extern FILE* yyin;

int main(int argc, char *argv[]) {
    t=init_table();
	yyparse();
	display_sym_tab();
	return 0;
}


