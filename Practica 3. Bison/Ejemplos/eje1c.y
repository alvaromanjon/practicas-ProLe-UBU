%{
#define _GNU_SOURCE // evitar warning "implicit declaration asprintf"
#include <stdio.h>  // printf, asprintf
#include <stdlib.h> // exit
#include <string.h> // strdup
// Los prototipos de las funciones (para evitar warnings)
int yylex();
void yyerror(const char *s);
void secure(int ifOk);
%}

%union {
  int num;
  char * string;
  }

%token <num>NUM <string>ID
%type <string> lexps
%type <string> exp
%type <string> term
%type <string> fac

%%
         // un 'programa' es una lista de expresioens
program: lexps {
         printf("%s",$1);
         free($1);
         }
       ;
lexps: exp ';' lexps {  
        secure(asprintf(&$$,"%s%s",$1,$3)); 
        free($1); free($3); 
        } 
     | { $$=strdup(""); } 
     ;
    // Esta producción es sólo para ilustrar como sería la asignación
exp: ID ':' '=' exp {
        secure(asprintf(&$$,"\tvalori %s\n%s\tasigna\n",$1,$4)); 
        free($1); free($4); 
         }
       ;
exp: exp '+' term { 
        secure(asprintf(&$$,"%s%s\tadd\n",$1,$3)); 
        free($1); free($3); 
        }
     | exp '-' term { 
        secure(asprintf(&$$,"%s%s\tsub\n",$1,$3)); 
        free($1); free($3); 
        }
     | term	{
        $$=$1;
        }
     ;
term: term '*' fac { 
        secure(asprintf(&$$,"%s%s\tmul\n",$1,$3)); 
        free($1); free($3); 
        }
     | fac	{  
        $$=$1;
        }
     ;
fac: NUM	{ 
        secure(asprintf(&$$,"\tmete %d\n", $1));
     }
   | ID   { 
        secure(asprintf(&$$,"\tvalord %s\n",$1)); 
        free($1); 
        } 
   | '(' exp ')'  { 
        $$=$2; 
        } 
   ;
%%
void yyerror (const char *s) {
   printf ("%s\n", s);
}

int main () {
   yyparse();
   return 0;
}

/** Helper function */
void secure(int ifOk) {
   if (ifOk<=0) { 
      fprintf(stderr,"Oh, oh! Something went wrong!\n");
      exit(-1);
   }
}

