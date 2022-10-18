%{
/* Practica 1
 * Autores:Maria Alonso y Alvaro Manjon
 */
#include <stdbool.h>
#include <string.h>
%}
 #define CP(from,to) free(to);to=strdup(from)
 // Funciones
 
 // Variables
 int numComentarios = 0, numAtributos = 0;
 char *etiqueta;

name [a-zA-Z|\_][a-zA-Z0-9\_\-\.]*
equal \s*\=\s*
val \'|\"{name}\'|\"

%x PI CDATA COM STAG ATTR
%%

"<![CDATA["					BEGIN(CDATA);
"]]>"						BEGIN(INITIAL);
"<?"						BEGIN(PI);
<PI>"?>"					BEGIN(INITIAL);
"<!--"            			BEGIN(COM);
<COM>"-->" 					{numComentarios++; BEGIN(INITIAL); }
"<"							BEGIN(STAG);
<STAG>^{name}				{CP(yytext, etiqueta); BEGIN(ATTR); }
<ATTR>{name}{equal}{val}	{numAtributos++; }

<*>.|\n				;


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
    printf("- Comentarios: %d.\n", numComentarios);  
    printf("- Elementos vacios: \n");
    printf("- La etiqueta " " es la que mas atributos tiene en su interior: \n");
    printf("- El valor mas largo de espacio de nombres es " " y el prefijo asociado es " "\n");

    return 0;
}