%{
#include <stdio.h>  // printf
#include <stdlib.h> // exit
// Los prototipos de las funciones (para evitar warnings)
int yylex();
void yyerror(const char *s);
%}
%token NUM
%%
command: exp ;
exp: exp '+' exp | exp '-' exp | exp '*' exp | '(' exp ')' | NUM ;
%%
void yyerror (const char *s) {
   printf ("%s\n", s);
   exit(-1);
}
int main () {
   yyparse();
   return 0;
}
