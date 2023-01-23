output: MaqPilaAbstrTrad.class
	java -cp . MaqPilaAbstrTrad

MaqPilaAbstrTrad.class: MaqPilaAbstrTrad.java
	javac *.java

MaqPilaAbstrTrad.java: practica2.jj
	jjdoc practica2.jj
	javacc practica2.jj

debug_parser: practica2.jj
	javacc -DEBUG_PARSER=true practica2.jj
	javac *.java
	java -cp . MaqPilaAbstrTrad

debug_lookahead: practica2.jj
	javacc -DEBUG_LOOKAHEAD=true practica2.jj
	javac *.java
	java -cp . MaqPilaAbstrTrad

debug_token_manager: practica2.jj
	javacc -DEBUG_TOKEN_MANAGER=true practica2.jj
	javac *.java
	java -cp . MaqPilaAbstrTrad

clean:
	$(RM) *.class
	$(RM) *.java
	$(RM) *~
	$(RM) *.html

test1: MaqPilaAbstrTrad.class
	./run MaqPilaAbstrTrad on in1.in

test2: MaqPilaAbstrTrad.class
	./run MaqPilaAbstrTrad on in2.in
