%{
/* Programa para hacer que los urls de
 * un documento se muestren al visualizar
 * los documentos, para que as'i sea 
 * posible su impresi'on
 */
/* de momento solo visualizo los urls
 no locales que comiencen por http:// o ftp://
*/
%}
 char *url, *proto;
 #define CP(from,to) free(to);to=strdup(from)
%x URL PROTO TEXTO
%%
"<a href=\""	{ BEGIN(PROTO); }
<PROTO>"http://"|"ftp://"	{ CP(yytext,proto); BEGIN(URL); }
<URL>[^"]*		{ CP(yytext,url); BEGIN(TEXTO); }
<TEXTO>"</a>"	{ printf(" (%s%s) \n", proto, url); BEGIN(INITIAL); }	
<*>.|\n			;
