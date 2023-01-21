%{
/* Ejemplo para ilustrar las condiciones de inicio inclusivas.
 * 12ab3 Aon12ab3 Bon12ab3 Zon12ab3
 * 00000 ---AAaaA ---BBbbB ---00000
 */
%}
%s A B
%%
Aon  {printf("---"); BEGIN(A);}
Bon  {printf("---"); BEGIN(B); }
Zon  {printf("---"); BEGIN(INITIAL);}
<*>" "  ECHO;
<A,B>[0-9]   { if ( YY_START==A ) printf("A"); else printf("B"); }
<A>.    printf("a");
<B>.    printf("b");
.       printf("0");
