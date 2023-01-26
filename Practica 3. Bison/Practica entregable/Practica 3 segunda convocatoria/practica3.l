%{
#include "y.tab.h"
#include <string.h>
%}
%option noyywrap

%x COM

DIGIT [0-9]
LETTER [a-zA-Z]

%%
"repeat"                      return REPEAT;
"until"                       return UNTIL;
"if"                          return IF; 
"then"                        return THEN;
"endif"                       return ENDIF;
"switch"                      return SWITCH;
"endswitch"                   return ENDSWITCH;
"else"                        return ELSE;
"case"                        return CASE;
"range"                       return RANGE;
"print"                       return PRINT;
{LETTER}({LETTER}|{DIGIT})*   { yylval.id = strdup(yytext); 
                                return ID; }
{DIGIT}+                      { yylval.num = atoi(yytext); 
                                return NUM; }
"="                           return EQUAL;
":"                           return COLON;
".."                          return RANGEDOTS;
","                           return COMMA;
"("                           return OPENPAREN;
")"                           return CLOSEPAREN;
"+"                           return PLUS;
"++"                          return DOUBLEPLUS;  
"-"                           return MINUS;
"--"                          return DOUBLEMINUS;
"*"                           return MULTIPLY;
"/"                           return DIVIDE;
[ \t\r\n]                     ;

"/*"                          { BEGIN(COM); }
<COM>"*/"                     { BEGIN(INITIAL); }
<COM>.|\n                     ;

