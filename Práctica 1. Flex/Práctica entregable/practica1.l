%{
/*Practica 1
*Autores:Maria Alonso y Alvaro Manjon
*/
#include <stdbool.h>
#include <string.h>
// Funciones
%}

 // Variables
 int numComentarios = 0;

%x COMENTARIOS CDATA
%%

"<![CDATA["			BEGIN(CDATA);
"]]>"				BEGIN(INITIAL);

"<!--"            	BEGIN(COMENTARIOS);
<COMENTARIOS>"-->" 	{numComentarios++; BEGIN(INITIAL);}

<*>.|\n				;


%%

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