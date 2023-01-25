%{
#include <stdio.h>  // printf
#include <stdlib.h> // exit
// Los prototipos de las funciones (para evitar warnings)
int yylex();
void yyerror(const char *s);
%}
%token NUM

%%
axioma: exp  { printf("=%d\n", $1); }; 
exp: exp '+' term { $$=$1+$3; }
     | exp '-' term {$$=$1-$3; }
     | term	{ $$=$1; } // default action
     ;
term: term '*' fac {$$=$1*$3; }
     | fac	{ $$=$1; }
     ;
fac: NUM	{ $$=$1; }
     | '(' exp ')'	{ $$=$2; } 
     ;
%%
void yyerror (const char *s) {
   printf ("%s\n", s);
   exit(-1);
}

int main () {
   yyparse();
   return 0;
}

