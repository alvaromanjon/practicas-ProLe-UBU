%%
(a|b)+/(c*a)    { printf("<%s>",yytext); }
.|\n            { ECHO; }

