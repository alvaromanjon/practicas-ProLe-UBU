%token NUM
%%
axioma: exp {  }; 
exp: exp '+' term { printf("\tadd\n"); }
     | exp '-' term { printf("\tsubs\n"); }
     | term	{  }
     ;
term: term '*' fac { printf("\tmul\n"); }
     | fac	{  }
     ;
fac: NUM	{ printf("\tmete %d\n", $1); }
     | '(' exp ')'	{ } 
     ;
%%
yyerror(char *s){printf("%s\n",s);}
main(){ yyparse(); }

