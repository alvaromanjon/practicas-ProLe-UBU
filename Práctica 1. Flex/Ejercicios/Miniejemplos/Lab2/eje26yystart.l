%{
/*
 * Un ejemplo que muestra como volver a una
 * condición de inicio previa.
 * Este es un ejemplo de entrada y salida
 * 12startA34(*56*)startB12(*34*)start012(*34*)56
 * ..::::::AA<<aa>>::::::BB<<bb>>::::::..........
 */
%}
%s A B C
 int preComState;
%%
startA  { printf("::::::"); BEGIN(A); }
startB  { printf("::::::"); BEGIN(B); }
start0  { printf("::::::"); BEGIN(0); }
<C>.    { if (preComState==A) printf("a"); else printf("b"); }
<C>"*)" { printf(">>"); BEGIN(preComState); }
<A>.    { printf("A"); }
<B>.    { printf("B"); }
<A,B>"(*" { printf("<<"); preComState = YY_START; BEGIN(C); }
.       { printf("."); }
