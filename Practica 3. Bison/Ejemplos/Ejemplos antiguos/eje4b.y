%{
#include <stdio.h>
#include <stdlib.h>
%}
%token NUM
%left '+' '-'
%left '*'
%%
command: exp ;
exp: exp '+' exp | exp '-' exp | exp '*' exp | '(' exp ')' | NUM;
%%
yyerror(char *s) { printf("%s\n",s); exit(-1);}
main(){ yyparse(); }

