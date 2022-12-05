%{
#include <stdio.h>
%}
%union {
  int p;
  int i;
}
%token <p> NP
%token <i> NI
%type <p> noterm
%%
axioma: NP NI { $<i>$=$1+$2; } noterm NP { printf("%d\n", $<i>3); };
noterm: NP NI { printf("%d %d %d %d\n",$<i>-1,$<i>0,$1,$2); } ;
%%
yyerror(char *s){printf("%s\n",s);}
main(){ yyparse(); }


