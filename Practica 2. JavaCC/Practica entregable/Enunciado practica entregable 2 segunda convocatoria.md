# Traductor con JavaCC - Segunda convocatoria

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

Se utilizan los delimitadores `/*` y `*/` para marcar el inicio y fin
de los comentarios.

Debe ser capaz de leer por entrada estándar (teclado) y por un fichero que se
le pase por argumento.

Suponer que, además de las vistas en los vídeos, el conjunto de instrucciones
de máquina de pila se ha ampliado con las instrucciones:

- `duplica`: duplica el elemento que hubiera en el tope.
- `print n`: imprime en secuencia los n elementos del tope de pila.
- `igual`: consume los dos elementos del tope de pila metiendo 1 si eran
  iguales, 0 si no lo eran.
- `menoroigual`: si tope-1 es menor o igual que tope dejará un 1 como nuevo tope
  tras consumir tope-1 y tope, en caso contrario lo que dejará en tope
  es un 0.
- `intercambia`: intercambia tope con tope-1.

La gramática sería:

```
   stmtsequence -> programstmt
                |  programstmt stmtsequence
    programstmt -> assigconstruct
                |  loopconstruct
                |  ifconstruct
                |  switchconstruct
                |  printstmt
  loopconstruct -> REPEAT stmtsequence UNTIL expr
    ifconstruct -> IF expr THEN stmtsequence ENDIF
switchconstruct -> SWITCH expr ':' listtests ENDSWITCH
                |  SWITCH expr ':' listtests ELSE stmtsequence ENDSWITCH
      listtests -> test | listtests test
           test -> CASE E: stmtsequence
                |  RANGE E..E: stmtsequence
      printstmt -> PRINT listexpr
      listexpr  -> expr | listexpr ',' expr
 assigconstruct -> ID '=' expr
           expr -> multexp ('+' multexp | '-' multexp)*
        multexp -> value ('*' value | '/' value)*
          value -> '(' expr ')' | NUM | ID
```

Para una entrada como `in1.in`:

```
print 10, 12
repeat a=a+1 until a-10
```

Debería dar:

```
    mete 10
    mete 12
    print 2
LBL0
    valori a
    valord a
    mete 1
    sum
    asigna
    valord a
    mete 10
    sub
    siciertovea LBL0
```

Para una entrada como `in2.in`:

```
switch a+2:
 case 2: print 2
 range 4..2*a: print 4
 else: print a, 666
endswitch
```

Debería dar:

```
    valord a
    mete 2
    sum
    duplica
    mete 2
    eq
    sifalsovea LBL1
    mete 2
    print 1
    vea LBL0
LBL1
    duplica
    mete 4
    intercambia
    menoroigual
    sifalsovea LBL2
    duplica
    mete 2
    valord a
    mul
    menoroigual
    sifalsovea LBL2
    mete 4
    print 1
    vea LBL0
LBL2
    valord a
    mete 666
    print 2
LBL0
```
Para una entrada como `in3.in`:

```
switch (a+2):
 range 4..2*a: 
    b=5
    c=8
    d=1
    repeat b=b+d print a until (b-c) 
 else: print a, 666
endswitch   
```

Debería dar:

```
    valord a
    mete 2
    sum
    duplica
    mete 4
    intercambia
    menoroigual
    sifalsovea LBL1
    duplica
    mete 2
    valord a
    mul
    menoroigual
    sifalsovea LBL1
    valori b
    mete 5
    asigna
    valori c
    mete 8
    asigna
    valori d
    mete 1
    asigna
LBL2:
    valori b
    valord b
    valord d
    sum
    asigna
    valord a
    print 1
    valord b
    valord c
    sub
    sifalsovea LBL2
    vea LBL0
LBL1:
    valord a
    mete 666
    print 2
LBL0:
```

Para una entrada como `in4.in`:

```
a = 0
b = 10
repeat
    switch (a-2):
        case 2: a=a+1
        else: 
            switch (b):
                case (b-5):
                    b=b-1
            endswitch
    endswitch
until (a-b) 
```

Debería dar:

```
    valori a
    mete 0
    asigna
    valori b
    mete 10
    asigna
LBL0:
    valord a
    mete 2
    sub
    duplica
    mete 2
    eq
    sifalsovea LBL2
    valori a
    valord a
    mete 1
    sum
    asigna
    vea LBL1
LBL2:
    valord b
    duplica
    valord b
    mete 5
    sub
    eq
    sifalsovea LBL4
    valori b
    valord b
    mete 1
    sub
    asigna
    vea LBL3
LBL4:
LBL3:
LBL1:
    valord a
    valord b
    sub
    sifalsovea LBL0
```

Para una entrada como `in5.in`:
```
/* Just a simple if */
if (var)           
   then print 1    
endif              
```

Debería dar:
```
    valord var
    sifalsovea LBL0
    mete 1
    print 1
LBL0:
```