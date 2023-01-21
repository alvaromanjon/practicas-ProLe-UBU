%{
/*
Ejemplo del uso de la sección de definiciones.
AUTOR: César Ignacio García Osorio
*/
%}

digit   [0-9]
digit2  0|1|2|3|4|5|6|7|8|9
nzdigit [1-9]
uint    {nzdigit}({digit})*
uintBAD xx
int     -?{uint}
udecim   ({digit})*\.({digit})+
decim   -?{udecim}
intOdec {int}|{decim}
intOde2 -?({uint}|{udecim})
exp     [eE][-+]?({digit})+
float   ({intOdec})({exp})   
float2  ({intOdec}){exp}   
float3  -?([0-9]+|[0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?   
 int decims=0;
 int floats=0;
 void showResults(void);
%%
{decim} {
    decims++;
    }

{float} {
    floats++;
    }

.|\n    {
    // Para evitar echoes de cosas
    // que no sean números o flotantes
    }
%%
int main() {
    yylex();
    showResults();
    return 0;
}

void showResults() {
   printf("Decimales: %d, Flotantes: %d\n", decims,floats);
}
