%%
(a|b)+/(c*d)    { printf("<%s>",yytext); }
.|\n            { ECHO; }

