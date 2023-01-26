output: practica3.out
	./practica3.out

practica3.out: lex.yy.c y.tab.c
	gcc lex.yy.c y.tab.c -o practica3.out

lex.yy.c: practica3.l
	flex practica3.l

y.tab.c: practica3.y
	bison -yd practica3.y

verbose: practica3.y
	bison -yv practica3.y
	flex practica3.l
	gcc lex.yy.c y.tab.c -o practica3.out
	./practica3.out

debug: practica3.y
	bison -yd practica3.y
	flex practica3.l
	gcc -g lex.yy.c y.tab.c -o practica3.out -DYYDEBUG
	./practica3.out

clean:
	$(RM) lex.yy.c
	$(RM) y.tab.c
	$(RM) y.tab.h
	$(RM) *.out

test1: practica3.out in1.in
	./run practica3.out on in1.in

test2: practica3.out in2.in
	./run practica3.out on in2.in

test3: practica3.out in3.in
	./run practica3.out on in3.in

test4: practica3.out in4.in
	./run practica3.out on in4.in	

test5: practica3.out in5.in
	./run practica3.out on in5.in