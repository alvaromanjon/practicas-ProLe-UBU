%{
/* Este programa pretende ilustrar las diferencias que
existen entre las condicones de inicio exclusivas %x y
las inclusivas %s. Ver tambi'en el fichero 
condiciones-inicio_s.l
*/
%}
%x A B
%%
<*>[ ] ECHO;
foobar	ECHO;
Aon	BEGIN(A);
Aoff	BEGIN(INITIAL);
Bon	BEGIN(B);
Boff	BEGIN(INITIAL);
<A,B>[0-9]	printf("d");
<A>.	printf("a");
<B>.	printf("b");
.	printf("0");	
%%
/* 
Como se estan usando condiciones de inicio exclusivas
(uso de directiva %x) el programa anterior es equivalente a:
<INITIAL>foobar	ECHO;
<INITIAL>Aon	BEGIN(A);
<INITIAL>Aoff	BEGIN(INITIAL);
<INITIAL>Bon	BEGIN(B);
<INITIAL>Boff	BEGIN(INITIAL);
<A,B>[0-9]	printf("d");
<A>.	printf("a");
<B>.	printf("b");
<INITIAL>.	printf("0");	
Ante una entrada como: Aon cc 45 Aoff cc 45
Imprimira: aa dd aaaa aa dd
Ante una entrada como: Aon cc 45 Bon cc 45 Boff cc 45
Imprimira: aa dd aaa aa dd aaaa aa dd
*/



