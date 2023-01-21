eje1:
	jjdoc eje1ParEqui.jj
	javacc eje1ParEqui.jj
	javac *.java
eje2:
	jjdoc eje2ParToLlaves.jj
	javacc eje2ParToLlaves.jj
	javac *.java
eje3:
	jjdoc eje3ExprRead.v1.jj
	javacc eje3ExprRead.v1.jj
	javac *.java
eje4:
	jjdoc eje4ExprRead.v2.jj
	javacc eje4ExprRead.v2.jj
	javac *.java
eje5:
	jjdoc eje5ExprEval.jj
	javacc eje5ExprEval.jj
	javac *.java
eje6:
	jjdoc eje6ExprToPost.jj
	javacc eje6ExprToPost.jj
	javac *.java
eje7:
	jjdoc eje7ExprToMaqPila.v1.jj
	javacc eje7ExprToMaqPila.v1.jj
	javac *.java
eje8:
	jjdoc eje8ExprToMaqPila.v2.jj
	javacc eje8ExprToMaqPila.v2.jj
	javac *.java
eje9:
	jjdoc eje9Lookahead.jj
	javacc eje9Lookahead.jj
	javac *.java
eje9dP:
	javacc -DEBUG_PARSER=true eje9Lookahead.jj
	javac *.java
	java -cp . Lookahead
eje9dLA:
	javacc -DEBUG_LOOKAHEAD=true eje9Lookahead.jj
	javac *.java
	java -cp . Lookahead
eje9dTM:
	javacc -DEBUG_TOKEN_MANAGER=true eje9Lookahead.jj
	javac *.java
	java -cp . Lookahead

clean:
	$(RM) *.class
	$(RM) *.java
	$(RM) *~
	$(RM) *.html

run1: ParEqui.class
	java -cp . ParEqui
run2: ParToLlaves.class
	java -cp . ParToLlaves
run3: ExprRead1.class
	java -cp . ExprRead1
run4: ExprRead2.class
	java -cp . ExprRead2
run5: ExprEval.class
	java -cp . ExprEval
run6: ExprToPost.class
	java -cp . ExprToPost
run7: ExprToMaqPila1.class
	java -cp . ExprToMaqPila1
run8: ExprToMaqPila2.class
	java -cp . ExprToMaqPila2
run9: Lookahead.class
	java -cp . Lookahead

ParEqui.class: eje1ParEqui.jj
	javacc eje1ParEqui.jj
	javac *.java
ParToLlaves.class: eje2ParToLlaves.jj
	javacc eje2ParToLlaves.jj
	javac *.java
ExprRead1.class: eje3ExprRead.v1.jj
	javacc eje3ExprRead.v1.jj
	javac *.java
ExprRead2.class: eje4ExprRead.v2.jj
	javacc eje4ExprRead.v2.jj
	javac *.java
ExprEval.class: eje5ExprEval.jj
	javacc eje5ExprEval.jj
	javac *.java
ExprToPost.class: eje6ExprToPost.jj
	javacc eje6ExprToPost.jj
	javac *.java
ExprToMaqPila1.class: eje7ExprToMaqPila.v1.jj
	javacc eje7ExprToMaqPila.v1.jj
	javac *.java
ExprToMaqPila2.class: eje8ExprToMaqPila.v2.jj
	javacc eje8ExprToMaqPila.v2.jj
	javac *.java
Lookahead.class: eje9Lookahead.jj
	javacc eje9Lookahead.jj
	javac *.java

test1: eje1
	. ./run ParEqui on in1.in
test2: eje2
	. ./run ParToLlaves on in2.in
test3: eje3
	. ./run ExprRead1 on in3.in
test4: eje4
	. ./run ExprRead2 on in4.in
test5: eje5
	. ./run ExprEval on in5.in
test6: eje6
	. ./run ExprToPost on in6.in
test7: eje7
	. ./run ExprToMaqPila1 on in7.in
test8: eje8
	. ./run ExprToMaqPila2 on in8.in
test9: eje9
	. ./run Lookahead on in9.in
