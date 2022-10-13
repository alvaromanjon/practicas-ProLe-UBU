%{
// WORK IN PROGRESS, 

/* Programa que extrae todas las URLs de un documento, tanto las que
 * aparecen como valor del atributo «href» de los elementos «a», como los
 * que aparecen en el atributo «src» de los elementos «img» y los valores
 * de otros atributos en los que también aparece un url, para ver cuáles
 * son estos atributos consultad: https://cutt.ly/bw1pSDS
 * AUTHOR: César Ignacio García Osorio
 */
 /*


*/
%}
 char *url;
 // Macro para facilitar la copia de yytext
 #define CP(from,to) free(to);to=strdup(from)
%x D URL1 URL2 TEXTO ATTS
%x HREF VIDEOURLS
hrefElements   (a|area|base|link)
srcElements    (audio|embed|frame|iframe|img|input|script|source|track)
videoAtts      (src|poster)
objectAtts     (classid|codebase|data|usemap)
%%
"<"{hrefElements}           { BEGIN(HREF); }
"<"{srcElements}            { BEGIN(SRC); }
"<"video                    { BEGIN(VIDEOURLS); }
"<"object                   { BEGIN(OBJECTURLS); }
<HREF>href=                 { BEGIN(D); }
<SRC>src=                   { BEGIN(D); }
<VIDEOURLS>{videoAtts}=     { BEGIN(D); }
<OBJECTURLS>{objectAtts}=   { BEGIN(D); }
<D>\"                       { BEGIN(URL2); }
<D>\'                       { BEGIN(URL1); }
<HREF,SRC,VIDEOURLS,OBJECTURLS>">"       { BEGIN(INITIAL); }
<HREF,SRC,VIDEOURLS,OBJECTURLS>.         ;
<blockquote cite=url>
<del cite=url>
<ins cite=url>
<q cite=url>



<applet codebase=url>
<body background=url>
<button formaction=url>
<command icon=url>
<form action=url>
<frame longdesc=url>
<head profile=url>
<html manifest=url>
<iframe longdesc=url>

<img longdesc=url>
<img usemap=url>

<input formaction=url>
<input usemap=url>

"<a href=\""    { BEGIN(URL2); }
"<a href='"     { BEGIN(URL1); }
<URL2>[^"]*      { CP(yytext,url); BEGIN(ATTS); }
<URL1>[^']*      { CP(yytext,url); BEGIN(ATTS); }
<ATTS>">"       { BEGIN(TEXTO); }
<TEXTO>.        { yymore(); }
<TEXTO>./"</a>" { printf("[%s](%s)\n", yytext, url); BEGIN(INITIAL); }	
<*>.|\n			;
