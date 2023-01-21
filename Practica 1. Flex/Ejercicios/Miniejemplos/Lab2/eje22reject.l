 /* Reconocimiento de lexemas que se solapan */
 // Ejemplo de la página 135 de Jhon R Levine, Flex & Bison, 2009.
 int npink,nink,npin;
%%
pink { npink++; REJECT; }
ink { nink++; REJECT; }
pin { npin++; REJECT; }
. |
\n ; /* el resto se descarta */
%%
%%
int main() {
  yylex();
  printf("pink: %d, ink: %d, pin: %d\n",
            npink,    nink,    npin);
  return 0;
}

