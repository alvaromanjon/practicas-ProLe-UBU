%{
/*
Programa para explicar la estructura general del
programa lex.yy.c generado por flex.
AUTOR: César Ignacio García Osorio
*/
/* CGO: Código C en la sección de definiciones */
#include <stdio.h>
#include <math.h>
#include <string.h>

%}

 // CGO: más código C en sección definiciones
 int num_ident=0;
 int globalVar=0;

%%
 // CGO: comentario al principio de la sección de reglas
 int localVar=0;

[a-zA-Z][a-zA-Z0-9]*    {
    /* CGO: Comentario en una acción */
    num_ident++; ECHO;
    }

\n  { 
    printf(" %d\n",num_ident); 
    }

.   {
    ;
    }

%%

// CGO: comentario en sección de rútinas de usuario
main() { 
  yylex(); 
}
