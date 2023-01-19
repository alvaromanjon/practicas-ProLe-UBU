%{
/* Con este programa se pretende contar el número
de líneas, palabras y carácteres de la entrada.
La principal característica es que permite leer
tanto de la entrada estándar como de un archivo
cuyo nombre se pasa como parámetro.
(Ejemplo 2-2 de Jhon R Levine, Tony Mason, Doug Brown, lex & yacc, 1990)
*/ 
unsigned charCount = 0, wordCount = 0, lineCount = 0;
%}
word	[^ \t\n]+
eol	    \n
%%
{word}	{wordCount++; charCount+=yyleng; }
{eol}	{ charCount++; lineCount++; }
.	charCount++;
%%

int main(int argc, char **argv) {
    if(argc > 1) {
        FILE *file;
        file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "no se puede abrir %s\n", argv[1]);
            exit(1);
        }
        yyin = file;
    } // else yyin=stdin; // the default vlue 
    yylex();
    printf("Líneas: %d\nPalabras: %d\nCaracteres: %d\n",
                lineCount,    wordCount,      charCount);
    return 0;
}
