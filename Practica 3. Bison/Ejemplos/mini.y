%{
#include <stdio.h>  // printf
#include <stdlib.h> // exit
// Los prototipos de las funciones (para evitar warnings)
int yylex();
void yyerror(const char *s);
%}
%%
/* S: 'a' {} 's' {printf("S->as\n");} */
S: 'a' 's' {printf("S->as\n");}
 | 'a' A 'b' {printf("S->aAb\n");}
 ;
A: 's' {printf("A->s\n");}
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

