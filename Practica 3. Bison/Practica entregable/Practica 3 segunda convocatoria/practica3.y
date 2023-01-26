%{
/**
* Práctica 3 2a convocatoria
* Procesadores del Lenguaje
* Curso 2022/2023
*
* Analizador sintáctico
*
* @author Álvaro Manjón Vara
* @date 26-01-2023
*/

#include <stdio.h>
#include <stdlib.h>

// Para compilar en modo debug, poner yydebug = 1 y usar en gcc el flag -DYYDEBUG
int yydebug = 1;

// Cabeceras de las funciones que genera flex
int yylex();
void yyerror(const char *s);

// Puntero del archivo de entrada
extern FILE *yyin;

// Variable estática para las etiquetas
static int nextNumber = 0;
int getNextNumber() {
    return nextNumber++;
}
%}

// Union para los tókenes
%union {
    int num;
    char *id;
}

// Definición de los tókenes
%token REPEAT UNTIL IF THEN ENDIF SWITCH ENDSWITCH ELSE CASE RANGE PRINT EQUAL COLON RANGEDOTS COMMA OPENPAREN CLOSEPAREN PLUS DOUBLEPLUS MINUS DOUBLEMINUS MULTIPLY DIVIDE
%token <num> NUM
%token <id> ID

// Precedencia de los operadores
%left PLUS MINUS
%left MULTIPLY DIVIDE

%%

/**
* stmtsequence -> programstmt
*               |  programstmt stmtsequence
*/
stmtsequence: programstmt
              | programstmt stmtsequence;

/**
* programstmt -> assigconstruct
*               |  loopconstruct
*               |  ifconstruct
*               |  switchconstruct
*               |  printstmt
*/
programstmt: assigconstruct
            | loopconstruct
            | ifconstruct
            | switchconstruct
            | printstmt;

/**
* loopconstruct -> REPEAT stmtsequence UNTIL expr
*/  
loopconstruct: { $<num>$ = getNextNumber(); }
              REPEAT  { printf("LBL%d\n", $<num>1); }
              stmtsequence UNTIL expr
              { printf("\tsifalsovea LBL%d\n", $<num>1); }
              ;

/**
* ifconstruct -> IF expr THEN stmtsequence ENDIF
*/
ifconstruct: { $<num>$ = getNextNumber(); }
            IF expr { printf("\tsifalsovea LBL%d\n", $<num>1); }
            THEN stmtsequence ENDIF
            { printf("LBL%d\n", $<num>1); }
            ;

/**
* switchconstruct -> SWITCH expr ':' listtests ENDSWITCH
*                 |  SWITCH expr ':' listtests ELSE stmtsequence ENDSWITCH
*/
switchconstruct: SWITCH 
                expr 
                COLON 
                listtests 
                ENDSWITCH  { printf("LBL%d\n", $<num>4); } //Etiqueta inicial
                | SWITCH 
                expr 
                COLON 
                listtests 
                ELSE COLON stmtsequence 
                ENDSWITCH { printf("LBL%d\n", $<num>4); } // Etiqueta inicial
                ;

/**
* listtests -> test
*            |  listtests test
*/
listtests: { $<num>$ = getNextNumber(); } // Creación de la etiqueta inicial
          test 
          | listtests test
          ;

/**
* test -> CASE E: stmtsequence
*      |  RANGE E..E: stmtsequence
* Se ha creado un nuevo no terminal para la gestión de las etiquetas:
* test -> labeltest stmtsequence
*      |  labeltest ':' stmtsequence
*/
test:
      labeltest stmtsequence { printf("\tvea LBL%d\n", $<num>0); // Etiqueta inicial
                              $<num>$=$<num>1; 
                              printf("LBL%d\n", $<num>$); } // Etiqueta actual
      | labeltest COLON stmtsequence { printf("\tvea LBL%d\n", $<num>0); // Etiqueta inicial
                                      $<num>$=$<num>1; 
                                      printf("LBL%d\n", $<num>$); } // Etiqueta actual
      ;

/**
* labeltest -> CASE E:
*            |  RANGE E..E
*/
labeltest: CASE 
      { printf("\tduplica\n"); }
      expr COLON 
      { printf("\tigual\n"); }
      { $<num>$=getNextNumber(); 
        printf("\tsifalsovea LBL%d\n", $<num>$ ); } // Siguiente etiqueta
      | 
      RANGE 
      { printf("\tduplica\n"); }
      expr 
      { printf("\tintercambia\n"); }
      { printf("\tmenoroigual\n"); }
      { $<num>$=getNextNumber(); 
        printf("\tsifalsovea LBL%d\n", $<num>$ ); } // Siguiente etiqueta
      RANGEDOTS 
      { printf("\tduplica\n"); }
      expr 
      { printf("\tmenoroigual\n"); }
      { $<num>$ = $<num>6; 
        printf("\tsifalsovea LBL%d\n", $<num>$); } // Siguiente etiqueta
      ;

/**
* printstmt -> PRINT listexpr
*/
printstmt: PRINT listexpr { printf("\tprint %d\n", $<num>2); };

/**
* listexpr  -> expr | listexpr ',' expr
*/
listexpr: expr { $<num>$=1; } // Inicialización del contador print
          | 
          listexpr COMMA expr { $<num>$=$<num>1+1; }; // Aumento del contador print

/**
* assigconstruct -> ID '=' expr
*                 |  ID '++'
*                 |  ID '--'
*/
assigconstruct: ID EQUAL { printf("\tvalori %s\n", $1); }
                expr  { printf("\tasigna\n"); }
                |
                ID DOUBLEPLUS { printf("\tvalori %s\n", $<id>1); 
                                printf("\tvalord %s\n", $<id>1);
                                printf("\tmete 1\n"); 
                                printf("\tsum\n"); 
                                printf("\tasigna\n"); }
                |
                ID DOUBLEMINUS { printf("\tvalori %s\n", $<id>1); 
                                 printf("\tvalord %s\n", $<id>1);
                                 printf("\tmete 1\n"); 
                                 printf("\tsub\n"); 
                                 printf("\tasigna\n"); }
                ;

/**
* expr -> multexp ('+' multexp | '-' multexp)*
*/
expr: multexp | expr PLUS multexp { printf("\tsum\n"); }
              | expr MINUS multexp  { printf("\tsub\n"); }
              ;

/**
* multexp -> value ('*' value | '/' value)*
*/
multexp: value | multexp MULTIPLY value { printf("\tmul\n"); }
               | multexp DIVIDE value { printf("\tdiv\n"); }
               ;

/**
* value -> '(' expr ')' | ID | NUM
*/
value: OPENPAREN expr CLOSEPAREN
      | ID  { printf("\tvalord %s\n", $1); }
      | NUM { printf("\tmete %d\n", $1); }

%%

/**
* Función que se llama cuando se produce un error sintáctico
*/
void yyerror (const char *s) {
   printf ("%s\n", s);
   exit(-1);
}

/**
* Función principal
*/
int main(int argc, char **argv) {
  if (argc > 1) {
    FILE *file = fopen(argv[1], "r");
    if (!file) {
      fprintf(stderr, "No se pudo abrir %s\n", argv[1]);
      exit(1);
    }
    yyin = file;
  } 
  yyparse();
  return 0;
}