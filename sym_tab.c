#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sym_tab.h"

table* init_table()	//allocate a new empty symbol table
{
	table* t = (table*)malloc(sizeof(table));
	t->head = NULL;
	return t;
}

symbol* init_symbol(char* name, int size, int type, int lineno,int scope) //allocates space for items in the list
{
	symbol* s =(symbol*)malloc(sizeof(symbol));
	s->name = (char*)malloc(sizeof(char)*(strlen(name)+1));
	strcpy(s->name,name);
	s->size = size;
	s->type = type;
	s->line = lineno;
	s->scope = scope;
	s->val = (char*)malloc(sizeof(char)*10);
	strcpy(s->val , "~"); //the initial value of the identifier is ~
	s->next = NULL;
	return s;
}

void insert_symbol(char* name, int size, int type, int lineno,int scope)	//inserts symbols into the table when declared
{
	symbol* s = init_symbol(name , size , type , lineno , scope); //this is for declaration of the variable

	//if the symbol table is empty initially then assigin it to the current id
	if(t->head == NULL)
	{
		t->head = s;
	}

	
	else{
		symbol* curr = t->head;
		while(curr->next)
		{
			curr = curr->next;
		}

		curr->next = s;
	}
}


void insert_val(char* name, char* v, int line)	//inserts values into the table when initialised
{
	if(t->head == NULL)
	{
		return;
	}

	symbol* curr = t->head;

	while(curr)
		{
			if(strcmp(curr->name,name) == 0)
			{
				strcpy(curr->val , v); // this is to store the actual value of the variable
				curr->line = line;
				return;
			}

			else{
				curr = curr->next;
			}
		}
}

char* retrieve_val(char* name)	//retrieves value from symbol table
{
	if(t->head == NULL)
	{
		return "~";
	}

	symbol* curr = t->head;

	while(curr)
		{
			if(strcmp(curr->name,name) == 0)
			{
				return curr->val;
			}

			else{
				curr = curr->next;
			}
		}

	return "~";

}

int retrieve_type(char* name)	//retrieves type from symbol table
{
	int type = -1; // default type
	if(t->head == NULL)
	{
		return type;
	}

	symbol* curr = t->head;

	while(curr)
		{
			if(strcmp(curr->name,name) == 0)
			{
				return curr->type;
			}

			else{
				curr = curr->next;
			}
		}
		
	return type;
}

int check_sym_tab(char* name)		//checks symbol table whether the variable has been declared or not
{					//return 0 if symbol not found and 1 if symbol is found
	int type = 0; // default type
	if(t->head == NULL)
	{
		return type;
	}

	symbol* curr = t->head;

	while(curr)
		{
			if(strcmp(curr->name,name) == 0)
			{
				return 1;
			}

			else{
				curr = curr->next;
			}
		}
		
	return type;
}

void display_sym_tab()			//displays symbol table
{
	symbol* curr = t->head;
	if(curr == NULL)
		return;
	printf("Name\tsize\ttype\tlineno\tscope\tvalue\n");
	while(curr!=NULL)
	{		
		printf("%s\t%d\t%d\t%d\t%d\t%s\n", curr->name, curr->size, curr->type, curr->line, curr->scope,curr->val);
		curr = curr->next;
	}
}

int type_check(char* value)		//checks the type from the value string
{
	/*
	1 --> string
	2 --> float
	3 --> int
	*/
	
	char *s=strchr(value,'\"');	//checks if there's a double quote then its a char
	if(s!=NULL)
		return 1; 
	char *f=strchr(value,'.');	//checks if there's a dot then its a float or double
	if(f!=NULL)
		return 3;
	return 2;			//otherwise returns int type
}

int size(int type)
{
	if(type==3)
		return 4;
	if(type==4)
		return 8;
	return type;
}

