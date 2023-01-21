test6bis:
	javacc test6bis.jj
	javac *.java
	java -cp . asig2maqPila
test6:
	jjdoc test6.jj
	javacc test6.jj
	javac *.java
	java -cp . expr2maqPila
test5:
	javacc test5.jj
	javac *.java
	java -cp . expr2post
test4:
	javacc test4.jj
	javac *.java
	java -cp . exprEval
test3bis:
	javacc test3bis.jj
	javac *.java
	java -cp . exprRead2
test3:
	javacc test3.jj
	javac *.java
	java -cp . exprRead
test2:
	javacc test2.jj
	javac *.java
	java -cp . par2llaves
test1:
	javacc test1.jj
	javac *.java
	java -cp . parEqui
clean:
	$(RM) *.class
	$(RM) *.java
	$(RM) *~
run1:
	java -cp . parEqui
run2:
	java -cp . par2llaves
run3:
	java -cp . exprRead 
run3bis:
	java -cp . exprRead2 
run4:
	java -cp . exprEval 
run5:
	java -cp . expr2post
run6:
	java -cp . expr2maqPila
run7:
	java -cp . sent2maqPila
run7bis:
	java -cp . sent2maqPila
