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

test1: MaqPilaAbstrTrad.class
	java -cp . MaqPilaAbstrTrad in1.in

test2: MaqPilaAbstrTrad.class
	java -cp . MaqPilaAbstrTrad in1.in
