%{
/* Con este programa se pretende contar el número
de líneas, palabras y carácteres de la entrada.
La principal característica es que permite leer
tanto de la entrada estándar como de un archivo
cuyo nombre se pasa como parámetro.

Example 2-1 de Jhon R Levine, Flex & Bison, 2009.
*/ 
int chars = 0;
int words = 0;
int lines = 0;
%}

%%

[a-zA-Z]+   { words++; chars += strlen(yytext); }
\n          { chars++; lines++; }
.           { chars++; }

%%

int main(int argc, char **argv)
{
    if(argc > 1) {
        if(!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]); // Informa del error
            return (1);
        }
    }
    yylex();
    printf("%8d%8d%8d\n", lines, words, chars);
}
