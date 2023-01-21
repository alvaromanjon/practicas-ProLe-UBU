%{
/* Con este programa se pretende contar el n'umero
de l'ineas, palabras y car'acteres de la entrada.
Mientras que con wcFilter.l se le'ia la entrada de
la entrada est'andar en este es posible especificar
el fichero sobre el que hacer las cuentas.
*/ 
unsigned charCount = 0, wordCount = 0, lineCount = 0;
%}
word	[^ \t\n]+
eol	\n
%%
{word}	{wordCount++; charCount+=yyleng; }
{eol}	{ charCount++; lineCount++; }
.	charCount++;
%%
main(int argc, char **argv)
{
	if(argc > 1) {
		FILE *file;
		file=fopen(argv[1], "r");
		if(!file) {
			fprintf(stderr, "no se puede abrir %s\n", argv[1]);
			exit(1);
		}
		yyin = file;
	} // else yyin=stdin; 
	yylex();
	printf("%d %d %d\n", lineCount, wordCount, charCount);
}
