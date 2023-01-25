%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);

extern FILE *yyin;
static int nextNumber = -1;

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
loopconstruct: REPEAT stmtsequence UNTIL expr;
ifconstruct: IF expr THEN stmtsequence ENDIF;
switchconstruct: SWITCH expr COLON listtests ENDSWITCH
                | SWITCH expr COLON listtests ELSE stmtsequence ENDSWITCH;
listtests: test | listtests test;
test: CASE expr COLON stmtsequence
      | RANGE expr RANGEDOTS expr COLON stmtsequence;
printstmt: PRINT listexpr;
listexpr: expr | listexpr COMMA expr;
assigconstruct: ID EQUAL expr;
expr: multexp | expr PLUS multexp | expr MINUS multexp;
multexp: value | multexp MULTIPLY value | multexp DIVIDE value;
value: OPENPAREN expr CLOSEPAREN
      | NUM
      | ID;

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
  } else {
    yyin = stdin;
    printf("Escribe el código: ");
  }
  yyparse();
  return 0;
}