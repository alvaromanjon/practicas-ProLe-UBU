%{
#include <stdio.h>  // printf
#include <stdlib.h> // exit
// Los prototipos de las funciones (para evitar warnings)
int yylex();
void yyerror(const char *s);
%}
%union {
  int p;
  int i;
}
%token <p> NP
%token <i> NI
%type <p> noterm
%%
axioma: NP NI { $<i>$=$1+$2; } noterm NP { printf("%d\n", $<i>3); };
noterm: NP NI { printf("%d %d %d %d\t",$<i>-1,$<i>0,$1,$2); } ;
%%
void yyerror (const char *s) {
   printf ("%s\n", s);
   exit(-1);
}
int main () {
   yyparse();
   return 0;
}

