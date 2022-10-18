%{
/* Programa que extrae las URLs de un documento imprimiéndolas
 * en el formato Markdown (supone que no se usan comillas simples)
 * AUTHOR: César Ignacio García Osorio
 * Los URLs pueden ser como el siguiente:
 *  <a href="http://www.ubu.es" alt="UBU" id="3">Universidad de Burgos</a>
 *  [Universidad de Burgos](http://www.ubu.es)
 */
%}
 char *url;
 #define CP(from,to) free(to);to=strdup(from)
%x URL TEXTO ATTS
%%
"<a href=\""    { BEGIN(URL); }
<URL>[^"]*      { CP(yytext,url); BEGIN(ATTS); }
<ATTS>">"       { BEGIN(TEXTO); }
<TEXTO>.        { yymore(); }
<TEXTO>./"</a>" { printf("[%s](%s)\n", yytext, url); BEGIN(INITIAL); }	
<*>.|\n			;
