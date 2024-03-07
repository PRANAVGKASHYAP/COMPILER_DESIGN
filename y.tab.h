
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INCLUDE = 258,
     INT = 259,
     FLOAT = 260,
     DOUBLE = 261,
     CHAR = 262,
     MAIN = 263,
     NUM = 264,
     IF = 265,
     WHILE = 266,
     DO = 267,
     FOR = 268,
     SWITCH = 269,
     CASE = 270,
     BREAK = 271,
     DEFAULT = 272,
     GTE = 273,
     LTE = 274,
     NEQ = 275,
     EQ = 276,
     RETURN = 277,
     STRING = 278,
     ID = 279,
     T_STRLITERAL = 280
   };
#endif
/* Tokens.  */
#define INCLUDE 258
#define INT 259
#define FLOAT 260
#define DOUBLE 261
#define CHAR 262
#define MAIN 263
#define NUM 264
#define IF 265
#define WHILE 266
#define DO 267
#define FOR 268
#define SWITCH 269
#define CASE 270
#define BREAK 271
#define DEFAULT 272
#define GTE 273
#define LTE 274
#define NEQ 275
#define EQ 276
#define RETURN 277
#define STRING 278
#define ID 279
#define T_STRLITERAL 280




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


