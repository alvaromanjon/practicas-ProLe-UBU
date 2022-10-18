 int num_line=0;

%%

.*\n   printf("%d\t%s",++num_line,yytext);

