output: practica1.out
	./practica1.out

practica1.out: lex.yy.c
	gcc lex.yy.c -o practica1.out -ll

lex.yy.c: practica1.l
	flex practica1.l

clean:
	$(RM) lex.yy.c
	$(RM) *.out

test: practica1.out test.xml
	cat test.xml
	./practica1.out test.xml