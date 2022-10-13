%{
/* Programa que extrae todas las URLs de un documento, tanto las que
 * aparecen como valor del atributo «href» de los elementos «a», como los
 * que aparecen en el atributo «src» de los elementos «img» y los valores
 * de otros atributos en los que también aparece un url, para ver cuáles
 * son estos atributos consultad: https://cutt.ly/bw1pSDS
 * AUTHOR: César Ignacio García Osorio
 *
 * Para simplificar el problema, considero que el HTML de entrada es correcto
 * y solo considero los atributos que no pueden tener más de un URL.
 */
%}

atts1 (action|background|cite|classid|codebase|data|formaction)
atts2 (href|icon|longdesc|manifest|poster|profile|src|usemap)
attsAll ({atts1}|{atts2})

tags1 (a|applet|area|audio|base|blockquote|body|button|command)
tags2 (del|embed|form|frame|frame|head|html|iframe|img|input)
tags3 (ins|link|object|q|script|source|track|video)
tagsAll ({tags1}|{tags2}|{tags3})

%x Q URL1 URL2 TEXTO ATT REST
%%
"<"{tagsAll}    { BEGIN(ATT); }
<ATT>{attsAll}= { BEGIN(Q); }
<ATT>">"        { BEGIN(INITIAL); }
<ATT>.          ;
<Q>\"           { BEGIN(URL2); }
<Q>\'           { BEGIN(URL1); }
<URL2>[^"]*     { printf("%s\n", yytext); BEGIN(REST); }
<URL1>[^']*     { printf("%s\n", yytext); BEGIN(REST); }
<REST>">"       { BEGIN(INITIAL); }
<REST>.         ;
<*>.|\n			;
