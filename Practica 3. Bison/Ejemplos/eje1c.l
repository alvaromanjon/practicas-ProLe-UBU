%{
#include "y.tab.h"
#include <string.h> // strdup
%}
%option noyywrap
id  [a-zA-Z][A-Za-z0-9]*
num 0|[1-9][0-9]*
%%
{num}	{ 
        yylval.num=atoi(yytext); 
        return NUM; 
    }
{id}	{ 
        // Copia yytext en memoria dinámica y devuelve puntero
        yylval.string=strdup(yytext);
        return ID; 
    }
[ \t\n] ;
.	return yytext[0];
