%{
#include <stdio.h>

// Los prototipos de las funciones (para evitar warnings)
int yylex();
void yyerror(const char *s);
%}

%union {
  int num;
  char * string;
  }

%token <num>NUM <string>ID

%%
lexps: exp ';' lexps {  } ; // overwrite default action $$=$1 
     | {  } ; // overwrite default action $$=$1 
     ;
exp: exp '+' term { printf("\tadd\n"); }
     | exp '-' term { printf("\tsubs\n"); }
     | term	{  }
     ;
term: term '*' fac { printf("\tmul\n"); }
     | fac	{  }
     ;
fac: NUM	{ printf("\tmete %d\n", $1); }
     | ID   { printf("\tvalord %s\n",$1); free($1); } 
     | '(' exp ')'	{ } 
     ;
%%
void yyerror (const char *s) {
   printf ("%s\n", s);
   exit(-1);
}

int main () {
   yyparse();
   return 0;
}
