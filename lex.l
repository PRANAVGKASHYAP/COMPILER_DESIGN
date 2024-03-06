%{
    #define YYSTYPE char*
    #include<stdio.h>
    #include<string.h>
    #include "y.tab.h"
    void yyerror(char *s);
    extern YYSTYPE yylval;
%}

%option yylineno
letter  [a-zA-Z]
digit   [0-9]
id  {letter}({letter}|{digit})*
str {letter}+".h"
number  {digit}+
ret "return"

%%

int {printf("INT \n "); return INT;}
float return FLOAT;
double return DOUBLE;
char return CHAR;
main return MAIN;
include {printf("Include \n"); return INCLUDE;}
{number} {
    yylval = strdup(yytext);
    return NUM ;
    }
if {printf("IF \n"); return IF;}
while {printf("WHILE \n"); return WHILE;}
do {printf("DO \n"); return DO;}
for {printf("FOR \n"); return FOR;}
switch return SWITCH;
case return CASE;
break return BREAK;
default return DEFAULT;
">=" { printf("GTE \n"); return GTE;}
"<=" { printf("LTE \n"); return LTE;}
"!=" { printf("NEQ \n"); return NEQ;}
"==" { printf("EQ \n"); return EQ;}
{ret} return RETURN;
{id} {
    printf("ID \n"); 
    yylval = strdup(yytext); // to store the actual value of the lexeme
    return ID;
    }
{str} {
    printf("Header \n"); 
    return STRING;
    }
[ \t\n]+ ;

(\/)(\/).* ;
"/*"[^*]*"*"[^/]*"/" ;

. return *yytext;

%%