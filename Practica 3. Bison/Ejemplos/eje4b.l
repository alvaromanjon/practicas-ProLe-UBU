%{
#include "y.tab.h"
%}
%option noyywrap
%%
[0-9]+	{ 
        yylval=atoi(yytext); 
        return NUM; 
    }
[ \t\n] ;
.	return yytext[0];
