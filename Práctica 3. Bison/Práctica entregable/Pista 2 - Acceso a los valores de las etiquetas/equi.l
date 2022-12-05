%{
#include "y.tab.h"
%}
%%
[ \t]    ;
"("    return OPAR;
")"    return CPAR;
