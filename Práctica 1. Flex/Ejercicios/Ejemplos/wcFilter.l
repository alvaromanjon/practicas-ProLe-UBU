%{
/* Con este programa se pretende contar el n'umero
de l'ineas, palabras y car'acteres de la entrada
*/ 
unsigned charCount = 0, wordCount = 0, lineCount = 0;
%}
word	[^ \t\n]+
eol	\n
%%
{word}	{wordCount++; charCount+=yyleng; }
{eol}	{ charCount++; lineCount++; }
.	charCount++;
%%
main()
{
	yylex();
	printf("%d %d %d\n", lineCount, wordCount, charCount);
}
