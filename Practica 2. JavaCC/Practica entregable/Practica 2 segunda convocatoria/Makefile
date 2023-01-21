output: MaqPilaAbstrTrad.class
	java -cp . MaqPilaAbstrTrad

MaqPilaAbstrTrad.class: MaqPilaAbstrTrad.java
	javac *.java

MaqPilaAbstrTrad.java: practica2.jj
	jjdoc practica2.jj
	javacc practica2.jj

clean:
	$(RM) *.class
	$(RM) *.java
	$(RM) *~
	$(RM) *.html

test1: output
	output in1.in

test2: output
	output in2.in
