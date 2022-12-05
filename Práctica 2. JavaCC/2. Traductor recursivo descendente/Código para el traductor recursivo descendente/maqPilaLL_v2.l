%{
#include "tokenes.h"
#include <string.h>
#include <math.h> // atoi
#include "yystype_v2.h"
extern YYSTYPE yylval;

%}
%x COM
%%
"/*"		BEGIN(COM);
<COM>.|\n	;
<COM>"*/"	BEGIN(0);
mod			return TMOD;
print	 	return TPRINT;
while		return TWHILE;
do			return TDO;
if			return TIF;
then		return TTHEN;
else		return TELSE;
endif		return TENDIF;
[0-9]+		{
			yylval.val=atoi(yytext); 
			return NUM;
			}
[a-zA-Z]+	{
			yylval.cad=strdup(yytext); 
			return ID;
			}
[ \n\r\t]	;
":="		return ASIGNA;
.			{
			return yytext[0];
			}
%%

