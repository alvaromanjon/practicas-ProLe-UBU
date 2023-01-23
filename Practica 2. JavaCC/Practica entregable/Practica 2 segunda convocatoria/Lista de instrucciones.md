# Lista de instrucciones posibles en la máquina de pila abstracta

- [x] `mete val`: Inserta val en la pila, donde val es un valor.

- [x] `valord pos`: Inserta en la pila el valor de la posición de datos `pos`.
- [x] `valori pos`: Inserta en la pila la dirección de memoria de la posición de datos `pos`.
- [ ] `saca` (_Revisar_): Elimina un valor del tope de la pila.
- [x] `asigna`: El tope de la pila se toma como valor, mientras que el valor que esté debajo de este se toma como dirección de memoria. Ambos elementos se sacan de la pila.
- [ ] `copia` (_Revisar_): Copia el tope de la pila e inserta el mismo elemento encima.
- [x] `vea etiq`: El flujo del programa salta a la etiqueta `etiq`, para que se ejecute lo que esté debajo de esa etiqueta.
- [x] `sifalsovea etiq`: En caso de que el valor del tope de la pila sea 0, se irá a la etiqueta `etiq`.
- [ ] `siciertovea etiq`: En caso de que el valor del tope de la pila sea distinto de 0, se irá a la etiqueta `etiq`.
- [x] `duplica`: Duplica el elemento que hubiera en el tope.
- [x] `print n`: Imprime en secuencia los n elementos del tope de pila.
- [x] `igual`: Saca los dos elementos del tope de pila e inserta un 1 si eran iguales, y un 0 si no.
- [x] `menoroigual`: Si el elemento tope-1 es menor o igual que el elemento tope de pila, se insertará un 1. Si no, se insertará un 0.
- [x] `intercambia`: Se intercambian los valores entre el tope y tope-1.
- [ ] `alto` (_Revisar_): Detiene la ejecución del programa.
