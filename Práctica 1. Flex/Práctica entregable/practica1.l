%{
/* Practica 1
 * Autores: Maria Alonso y Alvaro Manjon
 */
%}
 #define CP(from,to) free(to);to=strdup(from)
 // Funciones
 //void MayorNumAtributos();
 
 // Variables
 int numComentarios = 0, numAtributostmp = 0, numAtributosMax = 0, elemVacios = 0;
 char *etiquetatmp, *etiquetamax, *nstmp, *nsmax, *nsurltmp, *nsurlmax;

name [a-zA-Z|\_][a-zA-Z0-9\_\-\.]*
equal \s*=
cdata \<\!\[CDATA\[

%x PI CDATA COM STAG STAGEXIT ATTR XMLNS XMLNSTAG XMLNSURL
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
<STAG>{name}":"				{yyless(0); BEGIN(XMLNS); } 
<XMLNS>{name}				CP(yytext, nstmp); 
<XMLNS>":"{name}			{yyless(0); BEGIN(XMLNSTAG); } 
<XMLNSTAG>{name}":"{name}	; 
<XMLNSTAG>{name}			CP(yytext, etiquetatmp); 
<XMLNSTAG>{equal}			BEGIN(XMLNSURL); 
<XMLNSURL>[^"]*				{CP(yytext, nsurltmp); BEGIN(ATTR); } 
<STAG>{name}				{CP(yytext, etiquetatmp); BEGIN(ATTR); } 
<ATTR>{name}{equal}			{numAtributostmp++; } 
<ATTR>"/>"					{elemVacios++; BEGIN(INITIAL); } 
<ATTR>">"					{BEGIN(STAGEXIT); } 
<STAGEXIT>"<"				{yyless(0); BEGIN(INITIAL);  } 
<STAGEXIT>{name}			BEGIN(INITIAL);
<STAGEXIT>"</"				{elemVacios++; BEGIN(INITIAL); } 
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
    printf("- Comentarios: %d\n", numComentarios);  
    printf("- Elementos vacios: %d\n", elemVacios);
    printf("- La etiqueta \"%s\" es la que mas atributos tiene en su interior: %d.\n", etiquetamax, numAtributosMax);
    printf("- El valor mas largo de espacio de nombres es \"%s\" y el prefijo asociado es \"%s\".\n", nsurlmax, nsmax);
    return 0;+
}
void mayorNumAtributos(int * numTmp, int * numMax, char * strTmp, char * srtMax){
	if(*numTmp > *numMax){
		*numMax = *numTmp;
		CP(*strTmp, *srtMax);
	} else {
		*numTmp = 0;
	}
	
}

void nombreMasLargo(){

}