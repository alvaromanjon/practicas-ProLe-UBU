%x COM
comON  "/*"
comOFF "*/"
%%
{comON}         {BEGIN(COM); printf("<"); }
<COM>.|\n 		printf(".");
<COM>{comOFF}   {BEGIN(INITIAL); printf (">");}
.|\n            printf("-");
