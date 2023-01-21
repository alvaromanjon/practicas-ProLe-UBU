%{
/* 
Programa contador de palabras para multiples ficheros
(Ejemplo 2-3 de Jhon R Levine, Tony Mason, Doug Brown, lex & yacc, 1990)
*/
unsigned long charCount = 0, wordCount = 0, lineCount = 0;
unsigned long totalCC = 0, totalWC = 0, totalLC = 0;
%}
%option noyywrap
word	[^ \t\n]+
eol	\n
%%

{word}	{wordCount++; charCount+=yyleng; }
{eol}	{ charCount++; lineCount++; }
.	charCount++;
%%

char **fileList;
unsigned currentFile = 0;
unsigned nFiles;
unsigned long totalCC = 0;
unsigned long totalWC = 0;
unsigned long totalLC = 0;


main(int argc, char **argv)
{
  FILE *file=NULL;
        
  fileList = argv+1;
  nFiles = argc-1;

  if ( nFiles==1 ) {
    /*
     * Debemos manipular el caso de un 'unico fichero
     * de forma diferente que el caso de m'ultiples ficheros ya
     * que no hace falta imprimir la l'inea de resumen
     *
     */
     currentFile = 1;
     file=fopen(argv[1], "r");
     if ( !file ) {
        fprintf(stderr, "no se puede abrir %s\n", argv[1]);
        exit(1);
     }
     yyin = file;
  }

  /*
   * como antes, se manipula cero o un fichero
   * de forma diferente de multiples ficheros
   */
  if ( nFiles>1 ) {
    if( !yywrap() ) { /* abrir el primer fichero */
      yylex(); 
      printf("%8lu %8lu %8lu %s\n", lineCount, wordCount, charCount, 
                            fileList[currentFile-1]);
      totalCC += charCount;
      totalWC += wordCount;
      totalLC += lineCount;
      printf("%8lu %8lu %8lu total\n", totalLC, totalWC, totalCC);
    }
  } else {
    yylex();
    printf("%8lu %8lu %8lu\n", lineCount, wordCount, charCount);
  }
  return 0;
}

/*
 * El analizador lexico llama a yywrap para manipular el EOF (por ejemplo,
 * para abrir un nuevo fichero, como en este caso
 */

yywrap()
{
  FILE *file=NULL;

  /* Si hay fichero previo, si hay más de uno y si este no es el último */
  if ( (currentFile!=0) && (nFiles>1) && (currentFile<nFiles) ) {
    /*
     * imprimimos las estadisticas del fichero previo
     */
     printf("%8lu %8lu %8lu %s\n", lineCount, wordCount, charCount, 
                   fileList[currentFile-1]);
     totalCC += charCount;
     totalWC += wordCount;
     totalLC += lineCount;
     charCount = wordCount = lineCount = 0;
     fclose(yyin); /* ya se ha acabado con este fichero */
  }

  while ( fileList[currentFile]!=(char*)0 ) {
     file = fopen(fileList[currentFile++], "r");
     if (file != NULL) {
        yyin = file;
        break;
     }
     fprintf(stderr, "no se puede abrir %s\n",fileList[currentFile-1]);
  }

  return (file ? 0 : 1); /* cero significa que hay mas entradas */
}

