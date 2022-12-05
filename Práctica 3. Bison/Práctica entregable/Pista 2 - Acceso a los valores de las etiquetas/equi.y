%{
/*
Ejemplito en el que se transforma una secuencia
de paréntesis equilibrados, en una secuencia de
palabras on cm, siendo n y m números, que indican
la apertura (open) y el cierre (close) de los paréntesis,
y donde el número identifica con que on se corresponde
el cm (n==m).

Ante una entrada como: (()(()()))()
generaría la salida: o1 o2 c2 o3 o4 c4 o5 c5 c3 c1 o6 c6.

Queda más claro se se pone la entrada sobre
la salida que genera:
(  (   ) (  (  )  (  )  )  )  (  )
o1 o2 c2 o3 o4 c4 o5 c5 c3 c1 o6 c6

En la generación de las etiquetas y los saltos en
la práctica aparece un problema similar que se puede
resolver del mismo modo
*/
#include <stdio.h>
#include <stdlib.h>

int getNextNumber()
{
   static int nextNumber=0;
   return ++nextNumber;
}
%}

%union {
  float unTipoDeValorQueNoUso;
  int etiq;
}

%token OPAR CPAR

%%

lequi: equi lequi | equi ;

equi: OPAR {$<etiq>$=getNextNumber(); printf("o%d ",$<etiq>$); }
      lequi
      CPAR { printf("c%d ",$<etiq>2); }
    | 
      OPAR {$<etiq>$=getNextNumber(); printf("o%d ",$<etiq>$); }
      CPAR { printf("c%d ",$<etiq>2); }
	;
%%
yyerror(char *s) { fprintf(stderr,"%s\n",s); exit(-1); }
main() { yyparse(); }
/*

%{
#include "y.tab.h"
%}
%%
[ \t]    ;
"("    return OPAR;
")"    return CPAR;

*/
