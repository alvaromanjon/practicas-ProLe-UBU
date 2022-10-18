%%
(a|b)*  { printf("<%s>",yytext); /* yymore(); */ }
[0-9]+  { printf("|%s|",yytext); }

