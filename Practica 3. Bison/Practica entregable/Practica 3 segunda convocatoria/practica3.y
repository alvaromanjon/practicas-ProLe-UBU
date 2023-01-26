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
              { printf("\tsiciertovea LBL%d\n", $<num>1); }
              ;

ifconstruct: IF expr THEN stmtsequence ENDIF;

switchconstruct: SWITCH expr COLON listtests ENDSWITCH
                | SWITCH expr COLON listtests ELSE COLON stmtsequence ENDSWITCH;

listtests: test | listtests test;

test: CASE { printf("\tduplica\n"); }
      expr COLON  { printf("\tigual\n"); }
      stmtsequence
      | RANGE { printf("\tduplica\n"); }
      expr  { printf("\tintercambia\n"); 
              printf("\tmenoroigual\n"); }
      RANGEDOTS { printf("\tduplica\n"); }
      expr COLON { printf("\tmenoroigual\n"); }
      stmtsequence;

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