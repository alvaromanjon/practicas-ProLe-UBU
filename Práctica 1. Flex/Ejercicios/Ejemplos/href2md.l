%{
/* Programa que extrae las URLs de un documento imprimiéndolas
 * en el formato Markdown (supone que no se usan comillas simples)
 * AUTHOR: César Ignacio García Osorio
 * Los URLs pueden ser como el siguiente:
 *  <a href="http://www.ubu.es" alt="UBU" id="3">Universidad de Burgos</a>
 *  <a href="http://example.com"><img src="logo.jpg" alt="a logo" width="2"></a>
 * Y generará:
 *  [Universidad de Burgos](http://www.ubu.es)
 *  [<img src="logo.jpg" alt="a logo" width="2">](http://example.com)
 */
%}
 char *url;
 // Macro para facilitar la copia de yytext
 #define CP(from,to) free(to);to=strdup(from)
%x URL1 URL2 TEXTO ATTS
%%
"<a href=\""    { BEGIN(URL2); }
"<a href='"     { BEGIN(URL1); }
<URL2>[^"]*      { CP(yytext,url); BEGIN(ATTS); }
<URL1>[^']*      { CP(yytext,url); BEGIN(ATTS); }
<ATTS>">"       { BEGIN(TEXTO); }
<TEXTO>.        { yymore(); }
<TEXTO>./"</a>" { printf("[%s](%s)\n", yytext, url); BEGIN(INITIAL); }	
<*>.|\n			;
