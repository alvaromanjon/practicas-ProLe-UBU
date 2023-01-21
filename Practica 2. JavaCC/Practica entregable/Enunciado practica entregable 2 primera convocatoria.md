# Traductor con JavaCC - Primera convocatoria

## Enunciado

Se trata de utilizar JavaCC para obtener un compilador que traduzca un 
lenguaje de alto nivel a código de máquina de pila abstracta. Básicamente
lo mismo que hace el analizador recursivo descendente en C explicado en clase.

El lenguaje de alto nivel es muy sencillo. No tiene declaración de tipos.
Y el único tipo que permite es el tipo entero. En las condiciones de las
instrucciones if y while el valor 0 se interpreta como falso y cualquier 
otro valor como cierto.
Los operadores de incremento/decremento `++` y `--` hacen que la variable 
aumente/decremente su valor en un entero.

Los comentarios en el lenguaje serán en línea comenzando con `!`.

Debe ser capaz de leer por entrada estándar (teclado) y por un fichero que se 
le pase por argumento.


La gramática del lenguaje es la siguiente:

```
   stmtsequence -> programstmt
                |  programstmt stmtsequence
    programstmt -> assigconstruct
                |  loopconstruct
                |  ifconstruct
                |  printstmt
  loopconstruct -> WHILE '(' expr ')' stmtsequence ENDWHILE
    ifconstruct -> ifthenstmt stmtsequence (elseifconstruct)* (elseconstruct)? ENDIF
     ifthenstmt -> IF '(' expr ')' THEN
elseifconstruct -> ELSEIF '(' expr ')' THEN stmtsequence
  elseconstruct -> ELSE stmtsequence
      printstmt -> PRINT expr (',' expr)*
 assigconstruct -> ID '=' expr 
                |  ID '++' 
                |  ID '--'
           expr -> multexp ('+' multexp | '-' multexp)*
        multexp -> value ('*' value | '/' value)*
          value -> '(' expr ')' | NUM | ID
```

NOTAS: Podría ser necesaria alguna transformación en la la gramática antes de
       empezar a programar en JavaCC.
       NUM representa un número entero e ID un identificador/variable del
       lenguaje (pueden contener números, letras y guiones bajos, pero no pueden 
       comenzar por número). El resto de comandos en mayúsculas representan 
       palabras reservadas del lenguaje.


Ante una entrada como:
```
var = 5 + 5                 ! la variable var toma el valor de 5 + 5
while (var) var-- endwhile  ! bucle para decrementar var
if (5 - var)                ! Condicional
then
  print 3 * 3
else
  print var - 0
endif
print 1, 2, 3, var          ! Imprimir varios valores
```

Debería mostrar (excepto quizá el número de las etiquetas):

```
	valori var
	mete 5
	mete 5
	sum
	asigna
LBL0
	valord var
	sifalsovea LBL1
	valori var
	valord var
	mete 1
	sub
	asigna
	vea LBL0
LBL1
	mete 5
	valord var
	sub
	sifalsovea LBL2
	mete 3
	mete 3
	mul
	print 
	vea LBL3
LBL2
	valord var
	mete 0
	sub
	print 
LBL3
	mete 1
	print 
	mete 2
	print 
	mete 3
	print 
	valord var
	print 
```


Ante una entrada como:

! Ejemplo de condicional anidada en un bucle while
```
while (7 - 5 + a)
  if (c - d)
  then print c
  else print d
  endif
endwhile
```

! Ejemplo de bucles anidados
```
while (a)
  while (b)
    print a - b
  endwhile
endwhile
```

Debería mostrar (excepto quizá el número de las etiquetas):

```
LBL0
	mete 7
	mete 5
	sub
	valord a
	sum
	sifalsovea LBL1
	valord c
	valord d
	sub
	sifalsovea LBL2
	valord c
	print 
	vea LBL3
LBL2
	valord d
	print 
LBL3
	vea LBL0
LBL1
LBL4
	valord a
	sifalsovea LBL5
LBL6
	valord b
	sifalsovea LBL7
	valord a
	valord b
	sub
	print 
	vea LBL6
LBL7
	vea LBL4
LBL5
```
