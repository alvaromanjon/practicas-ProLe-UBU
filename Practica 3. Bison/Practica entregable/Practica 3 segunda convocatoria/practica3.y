%{
#include <stdio.h>
#include <stdlib.h>

// Para compilar en modo debug, poner yydebug = 1
int yydebug = 1;

int yylex();
void yyerror(const char *s);

extern FILE *yyin;
static int nextNumber = 0;

int getNewLabel() {
    return nextNumber++;
}
%}

%union {
    int num;
    char *id;
}

%token REPEAT UNTIL IF THEN ENDIF SWITCH ENDSWITCH ELSE CASE RANGE PRINT EQUAL COLON RANGEDOTS COMMA OPENPAREN CLOSEPAREN PLUS MINUS MULTIPLY DIVIDE
%token <num> NUM
%token <id> ID

%left PLUS MINUS
%left MULTIPLY DIVIDE

%%

stmtsequence: programstmt
              | programstmt stmtsequence;

programstmt: assigconstruct
            | loopconstruct
            | ifconstruct
            | switchconstruct
            | printstmt;

loopconstruct: { int initialLabel = getNewLabel(); $<num>$ = initialLabel; }
              REPEAT  { printf("LBL%d\n", $<num>1); }
              stmtsequence UNTIL expr
              { printf("\tsifalsovea LBL%d\n", $<num>1); }
              ;

ifconstruct: { int initialLabel = getNewLabel(); $<num>$ = initialLabel; }
            IF expr { printf("\tsifalsovea LBL%d\n", $<num>1); }
            THEN stmtsequence ENDIF
            { printf("LBL%d\n", $<num>1); }
            ;

switchconstruct: SWITCH 
                expr 
                COLON 
                listtests 
                ENDSWITCH  { printf("LBL%d\n", $<num>4); }
                | SWITCH 
                expr 
                COLON 
                listtests 
                ELSE COLON stmtsequence 
                ENDSWITCH { printf("LBL%d\n", $<num>4); }
                ;

listtests: { $<num>$ = getNewLabel(); }
          test 
          | listtests test
          ;

test:
      test2 stmtsequence { printf("\tvea LBL%d\n", $<num>0); 
                          $<num>$=$<num>1; printf("LBL%d\n", $<num>$); }
      | test2 COLON stmtsequence { printf("\tvea LBL%d\n", $<num>0); 
                                  $<num>$=$<num>1; printf("LBL%d\n", $<num>$); }
      ;

test2: CASE 
      { printf("\tduplica\n"); }
      expr COLON 
      { printf("\tigual\n"); }
      { $<num>$=getNewLabel(); printf("\tsifalsovea LBL%d\n", $<num>$ ); }
      | 
      RANGE 
      { printf("\tduplica\n"); }
      expr 
      { printf("\tintercambia\n"); }
      { printf("\tmenoroigual\n"); }
      { $<num>$=getNewLabel(); 
      printf("\tsifalsovea LBL%d\n", $<num>$ ); }
      RANGEDOTS 
      { printf("\tduplica\n"); }
      expr 
      { printf("\tmenoroigual\n"); }
      { $<num>$ = $<num>6; printf("\tsifalsovea LBL%d\n", $<num>$); }
      ;

printstmt: PRINT listexpr { printf("\tprint %d\n", $<num>2); };

listexpr: expr { $<num>$=1; } | listexpr COMMA expr { $<num>$=$<num>1+1; };

assigconstruct: ID EQUAL { printf("\tvalori %s\n", $1); }
                expr  { printf("\tasigna\n"); };

expr: multexp | expr PLUS multexp { printf("\tsum\n"); }
              | expr MINUS multexp  { printf("\tsub\n"); }
              ;

multexp: value | multexp MULTIPLY value { printf("\tmul\n"); }
               | multexp DIVIDE value { printf("\tdiv\n"); }
               ;

value: OPENPAREN expr CLOSEPAREN
      | ID  { printf("\tvalord %s\n", $1); }
      | NUM { printf("\tmete %d\n", $1); }

%%

void yyerror (const char *s) {
   printf ("%s\n", s);
   exit(-1);
}

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