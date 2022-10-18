%%
(a|b)*  { printf("<%s>",yytext); yyless(2); }
[0-9]+  { printf("|%s|",yytext); }

