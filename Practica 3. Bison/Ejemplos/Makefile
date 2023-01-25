OS := $(shell uname)
ifeq ($(OS),Darwin)
	BISON=/usr/local/Cellar/bison/3.0.4/bin/bison
else
	BISON=bison
endif
eje1: eje1.l eje1.y
	flex eje1.l
	bison -yd eje1.y
	gcc lex.yy.c y.tab.c -o eje1
eje1b: eje1b.l eje1b.y
	flex eje1b.l
	bison -yd eje1b.y
	gcc lex.yy.c y.tab.c -o eje1b
eje1c: eje1c.l eje1c.y
	flex eje1c.l
	bison -yd eje1c.y
	gcc lex.yy.c y.tab.c -o eje1c
eje2: eje2.l eje2.y
	flex eje2.l
	bison -yd eje2.y
	gcc lex.yy.c y.tab.c -o eje2
eje3: eje3.l eje3.y
	flex eje3.l
	bison -yd eje3.y
	gcc lex.yy.c y.tab.c -o eje3
eje4: eje4.l eje4.y
	flex eje4.l
	bison -yd eje4.y
	gcc lex.yy.c y.tab.c -o eje4
eje4b: eje4b.l eje4b.y
	flex eje4b.l
	bison -yd eje4b.y
	gcc lex.yy.c y.tab.c -o eje4b
eje4v: eje4b.l eje4b.y # verbose
	bison -yv eje4.y
	less eje4.output
eje4p1: eje4b.l eje4b.y # pdf1
	$(BISON) -yg eje4.y -b eje4
	dot -Tpdf eje4.dot -o eje4.pdf
mini: mini.l mini.y 
	flex mini.l
	bison -y mini.y
	gcc lex.yy.c y.tab.c -o mini

clean:
	$(RM) lex.yy.c
	$(RM) y.tab.c
	$(RM) y.tab.h
	$(RM) eje1 eje1b eje1c eje2 eje3 eje4 eje4b mini
	$(RM) eje1.out eje1b.out eje1c.out eje2.out eje3.out eje4.out eje4b.out mini.out

run1: eje1.out
	./eje1.out
run1b: eje1b.out
	./eje1b.out
run1c: eje1c.out
	./eje1c.out
run2: eje2.out
	./eje2.out
run3: eje3.out
	./eje3.out
run4: eje4.out
	./eje4.out
run4b: eje4b.out
	./eje4b.out

test1: eje1.out in1.in
	. ./run eje1 on in1.in 
test1b: eje1b.out in1b.in
	. ./run eje1b on in1b.in 
test1c: eje1c.out in1c.in
	. ./run eje1c on in1c.in 
test2: eje2.out in2.in
	. ./run eje2 on in2.in 
test3: eje3.out in3.in
	. ./run eje3 on in3.in 
test4: eje4.out in4.in
	. ./run eje4 on in4.in 
test4b: eje4b.out in4b.in
	. ./run eje4b on in4b.in 
testmini: mini.out inmini.in
	. ./run mini on inmini.in 
