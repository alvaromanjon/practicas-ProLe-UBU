%{
/* Este programa pretende ilustrar las diferencias que
existen entre las condicones de inicio exclusivas %x y
las inclusivas %s. Ver tambi'en el fichero 
condiciones-inicio_x.l
*/
%}
%s A B
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
Como se estan usando condiciones de inicio inclusivas
(uso de directiva %s) el programa anterior es equivalente a:
<*>[ ] ECHO;
<*>foobar	ECHO;
<*>Aon	BEGIN(A);
<*>Aoff	BEGIN(INITIAL);
<*>Bon	BEGIN(B);
<*>Boff	BEGIN(INITIAL);
<A,B>[0-9]	printf("d");
<A>.	printf("a");
<B>.	printf("b");
<*>.	printf("0");	

Ante una entrada como: Aon cc 45 Aoff cc 45 
Imprimira: aa dd  00 00
Ante una entrada como: Aon cc 45 Bon cc 45 Boff cc 45
Imprimira: aa dd  bb dd  00 00
*/






