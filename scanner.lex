%{
#include <math.h>
#include "output.hpp"
#include "parser.tab.hpp"
#include <iostream>
#include <string>
using std::string;
using namespace output;
int line_number = 1;
%}
%option yylineno
%option noyywrap

EQUALITY "=="|"!="
RELATIONAL "<"|">"|"<="|">="
MULBINOP "*"|"/"
ADDBINOP "+"|"-"
COMMENT \/\/[^\r\n]*(\r|\n|\r\n)?
ID [a-zA-Z]([a-zA-Z]|[0-9])*
NUM ([1-9][0-9]*)|0
ESCAPE ((\\t|\\n|\\r|\\\"|\\\\|\\0|\\(x([0-9]|[a-fA-F])([0-9]|[a-fA-F])))
UNDEFIND_ESCAPE \\[^\n\r\"]|\\x[^\n\r\"]|\\x
STRING \"({ESCAPE})|[^\n\r\"\\]|({UNDEFIND_ESCAPE}))*\"
UNCLOSED_STRING \"[^\"]*


%%
"void" 		 		{return VOID;}
"int" 		 		{return INT;}
"byte" 		 		{return BYTE;}
"b" 		 		{return B;}
"bool" 		 		{return BOOL;}
"and"			 	{return AND;}
"or" 		 		{return OR;}
"not" 				{return NOT;}
"true" 				{return TRUE;}
"false" 			{return FALSE;}
"return" 			{return RETURN;}
"if" 	 			{return IF;}
"else" 	 			{return ELSE;}
"while" 	 		{return WHILE;}
"break" 	 		{return BREAK; }
"continue" 	 		{return CONTINUE;}
"switch" 	 		{return SWITCH;}
"case" 	 			{return CASE;}
"default" 	 		{return DEFAULT;}
":"		 	 		{return COLON;}
";" 	 			{return SC;}
","		 			{return COMMA;}
"("		 	 		{return LPAREN;}
")"		 	 		{return RPAREN;}
"{"		 	 		{return LBRACE;}
"}"		 	 		{return RBRACE;}
"="		 	 		{return ASSIGN;}
{EQUALITY} 	 		{return EQUALITY;}
{RELATIONAL}        {return RELATIONAL;}
{MULBINOP} 	 		{return MULBINOP;}
{ADDBINOP}          {return ADDBINOP;}
{COMMENT} 	 		{}
{ID} 	 	 		{return ID;}
{NUM} 	 	 		{return NUM;}
{STRING}		 	{return STRING;}
[ \t\r]		 		{}
\n			 		{line_number++;}
{UNCLOSED_STRING}   { errorLex(line_number); exit(1);}
. 			 		{ errorLex(line_number); exit(1);}
%%