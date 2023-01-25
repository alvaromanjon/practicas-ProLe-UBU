%{
#include "y.tab.h"
%}
%%
[0-9]*[02468]	{
	yylval.p=atoi(yytext);
	return NP; 
	}
[0-9]*[13579]	{
	yylval.i=atoi(yytext);
	return NI; 
	}

