%{
/* Practica 1
 * Autores: Maria Alonso y Alvaro Manjon
 */
 #include <string.h>
%}
 // copia y libera memoria
 #define CP(from,to) free(to);to=strdup(from)
 // Funciones
 void mayorNumAtributos();
 void mayorNs();
 
 // Variables
 int numComentarios = 0, numAtributostmp = 0, numAtributosMax = 0, elemVacios = 0;
 char *etiquetatmp, *etiquetamax, *nstmp, *nsmax, *nsurltmp, *nsurlmax;

name [a-zA-Z|\_][a-zA-Z0-9\_\-\.]*
equal \s*=
cdata \<\!\[CDATA\[

%x PI CDATA COM STAG STAGEXIT ATTR XMLNS XMLNSTAG XMLNSURL
%%
	// definicion de reglas
{cdata}						BEGIN(CDATA); 
<CDATA>"]]>"				BEGIN(INITIAL); 
"<?"						BEGIN(PI); 
<PI>"?>"					BEGIN(INITIAL); 
"<!--"            			BEGIN(COM); 
<COM>"-->" 					{numComentarios++; BEGIN(INITIAL); } 
"</"						;  
"<"							BEGIN(STAG); 
<STAG>"!"					BEGIN(INITIAL); 
<STAG>{name}":"				{yyless(0); BEGIN(XMLNS); } 
<XMLNS>{name}				CP(yytext, nstmp); 
<XMLNS>":"{name}			{yyless(0); BEGIN(XMLNSTAG); } 
<XMLNSTAG>{name}":"{name}	; 
<XMLNSTAG>{name}			CP(yytext, etiquetatmp); 
<XMLNSTAG>{equal}			BEGIN(XMLNSURL); 
<XMLNSURL>[^"]*				{CP(yytext, nsurltmp); mayorNs(); BEGIN(ATTR); } 
<STAG>{name}				{CP(yytext, etiquetatmp); BEGIN(ATTR); } 
<ATTR>{name}{equal}			{numAtributostmp++; } 
<ATTR>"/>"					{elemVacios++; mayorNumAtributos(); BEGIN(INITIAL); } 
<ATTR>">"					{mayorNumAtributos(); BEGIN(STAGEXIT); } 
<STAGEXIT>"<"				{yyless(0); BEGIN(INITIAL);  } 
<STAGEXIT>{name}			BEGIN(INITIAL);
<STAGEXIT>"</"				{elemVacios++; BEGIN(INITIAL); } 
<*>.|\n						;

%%

int main(int argc, char **argv) {
// pasamos un unico argumento
	if(argc > 1) {
		// abrimos y leemos el archivo 
        if(!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]); // Informa del error
            return (1);
        }
    }

	CP("", nsurlmax);

    yylex();
	
	// imprime los resultados
    printf("- Comentarios: %d\n", numComentarios);  
    printf("- Elementos vacios: %d\n", elemVacios);
    printf("- La etiqueta \"%s\" es la que mas atributos tiene en su interior: %d.\n", etiquetamax, numAtributosMax);
    printf("- El valor mas largo de espacio de nombres es \"%s\" y el prefijo asociado es \"%s\".\n", nsurlmax, nsmax);
    return 0;
}

// comprueba cual es la etiqueta con mayor numero de atributos
void mayorNumAtributos() {
	if (numAtributostmp > numAtributosMax) {
		numAtributosMax = numAtributostmp;
		CP(etiquetatmp, etiquetamax);
	} else {
		numAtributostmp = 0;
	}
}

//Indica cual es el espacio de nombres mas largo
void mayorNs() {
	if (strlen(nsurltmp) > strlen(nsurlmax)) {
		CP(nsurltmp, nsurlmax);
		CP(nstmp, nsmax);
	}
}