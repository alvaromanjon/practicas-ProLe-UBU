#include "tokenes.h"
#include "etiqueta.h"
#include <stdio.h> /* definici'on de stderr y fprintf */
#include <stdlib.h>

#include "yystype_v2.h"
YYSTYPE yylval;

int preanalisis;

parea(int t)
{
     if ( preanalisis == t )
           preanalisis = yylex();
     else error();
}

error()
{
     fprintf(stderr, "error de sintaxis\n"); /* imprime mensaje de error */
     exit(1);                                /* y despu'es se detiene */
}


ETIQUETA etiqnueva() {
  static ETIQUETA lastetiq=-1;
  lastetiq=lastetiq+1;
  return lastetiq;
}

main()
{
     preanalisis = yylex();
     sentencia();
     printf("\n"); /* agrega un car'acter de l'inea nueva al final */
}

programa()
{
     sentencia();
}

expr()
{
     termino();
     while(1)
         if ( preanalisis == '+' ) {
               parea('+'); termino(); printf("\tadd\n");
         }
         else if ( preanalisis == '-' ) {
               parea('-'); termino(); printf("\tsub\n");
         }
         else break;
}

termino()
{
     factor();
     while(1)
         if ( preanalisis == '*' ) {
               parea('*'); factor(); printf("\tmul\n");
         }
         else if ( preanalisis == '/' ) {
               parea('/'); factor(); printf("\tdiv\n");
         }
         else if ( preanalisis == TMOD ) {
               parea(TMOD); factor(); printf("\tmod\n");
         }
         else break;
}

factor()
{
     if ( preanalisis==NUM ) {
           printf("\tmete\t%d\n", yylval.val);
           parea(preanalisis);
     }
     else if ( preanalisis==ID ) {
           printf("\tvalord\t%s\n", yylval.cad);free(yylval.cad);
           parea(preanalisis);
     }
     else if ( preanalisis=='(' ) {
           parea('(');
           expr();
           parea(')');
     }
     else error();
}



sentencia()
{
     if ( preanalisis==ID ) {
           printf("\tvalori\t%s\n", yylval.cad);
           parea(ID);
	   parea(ASIGNA);
	   expr();
           printf("\tasigna\n");
     }
     else if ( preanalisis==TPRINT ) {
	parea(TPRINT); 
	expr(); printf("\tprint\n");
     }

     else if ( preanalisis==TWHILE ) {
           ETIQUETA prueba, etiq;
           parea(TWHILE);
           prueba=etiqnueva();
           printf("LBL%d:\n", prueba);
 	   expr();
	   etiq=etiqnueva();
	   printf("\tsifalsovea LBL%d\n",etiq);
	   parea(TDO);
	   sentencia();
	   printf("\tvea LBL%d\n",prueba);
	   printf("LBL%d:\n",etiq);
     }
     else if ( preanalisis==TIF ) {
	   ETIQUETA falso=etiqnueva();
           parea(TIF);
           expr();
           parea(TTHEN);
	   printf("\tsifalsovea LBL%d\n",falso);
	   sentencia();
	   elseopcional(falso);
     }
     else if ( preanalisis=='{' ) {
           parea('{');
           listaSentencias();
           parea('}');
     }
     else error();
}

elseopcional(ETIQUETA falso)
{
     if ( preanalisis==TENDIF ) {
           printf("LBL%d:\n", falso);
           parea(TENDIF);
     }
     else if ( preanalisis==TELSE ) {
           ETIQUETA despues=etiqnueva();
	   printf("\tvea LBL%d\n",despues);
	   printf("LBL%d:\n", falso);
	   parea(TELSE);
	   sentencia();
	   printf("LBL%d:\n", despues);
           parea(TENDIF);
     }
     else error();
}

listaSentencias()
{
     sentencia();
     while(1)
         if ( preanalisis == ';' ) {
               parea(';'); sentencia();
         }
         else if ( preanalisis == '}' ) {
               break;
         }
         else error();
}
