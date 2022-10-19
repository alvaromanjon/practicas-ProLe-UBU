%{
/* Practica 1
 * Autores:Maria Alonso y Alvaro Manjon
 */
#include <stdbool.h>
#include <string.h>
%}
 #define CP(from,to) free(to);to=strdup(from)
 // Funciones
 void MayorNumAtributos();
 
 // Variables
 int numComentarios = 0, numAtributostmp = 0, elemVacios = 0;
 char *etiquetatmp, *nstmp;

name [a-zA-Z|\_][a-zA-Z0-9\_\-\.]*
equal \s*=
cdata \<\!\[CDATA\[
emptytag "<"
 //val (\'|\")[^']*(\'|\")

%x PI CDATA COM STAG ATTR XMLNS XMLNSU
%%

{cdata}						BEGIN(CDATA);
<CDATA>"]]>"				BEGIN(INITIAL);
"<?"						BEGIN(PI);
<PI>"?>"					BEGIN(INITIAL);
"<!--"            			BEGIN(COM);
<COM>"-->" 					{numComentarios++; BEGIN(INITIAL); }
"</"						;
"<"							BEGIN(STAG);
<STAG>"!"					BEGIN(INITIAL);
<STAG>{name}":"				BEGIN(XMLNS);
<XMLNS>{name}				{CP(yytext, etiquetatmp); BEGIN(ATTR); }
<STAG>{name}				{CP(yytext, etiquetatmp); BEGIN(ATTR); }
<ATTR>{name}{equal}			{numAtributostmp++; }
<ATTR>"/>"					{elemVacios++; BEGIN(INITIAL); }
<ATTR>">"					{yymore(); BEGIN(STAG); }
<STAG>{emptytag}			{elemVacios++; BEGIN(INITIAL); }
<STAG>\>?\n					BEGIN(INITIAL); //TODO mejorar esta regla
<*>.|\n						;


%%

//TODO comprobar si hay que cambiar el main o no
int main(int argc, char **argv) {

	if (argc > 1) {
		FILE *file;
		file = fopen(argv[1], "r");

		if(!file) {
			fprintf(stderr, "no se puede abrir %s\n", argv[1]);
			exit(1);
		}

		yyin = file;
	}
	else {
		yyin = stdin;
	}

    yylex();
	printf("- DEBUG: Atributos totales: %d.\n", numAtributostmp);
    printf("- Comentarios: %d.\n", numComentarios);  
    printf("- Elementos vacios: %d.\n", elemVacios);
    printf("- La etiqueta " " es la que mas atributos tiene en su interior: \n");
    printf("- El valor mas largo de espacio de nombres es " " y el prefijo asociado es " "\n");

    return 0;
}

void MayorNumAtributos(){
	if(int i = 0; i < ; i++){
		if ( > ){
			
		}

	}
}