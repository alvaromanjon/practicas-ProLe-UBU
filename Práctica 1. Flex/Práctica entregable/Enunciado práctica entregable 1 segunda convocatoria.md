# Análisis léxico con flex

## Enunciado

Enunciado provisional de la práctica de flex de segunda convocatoria.

Crear un analizador léxico para procesar un documento XML 
realizando las operaciones necesarias para que al finalizar el 
procesado permita mostrar las siguientes estadísticas:
- La línea en la que empieza comentario más largo.
- El nombre de la etiqueta con más espacios de nombres declarados.
- El atributo con nombre más largo, sin tener en cuenta los prefijos
  de espacio de nombre.
- El número de elementos vacíos, aquellos que finalizan sin tener etiquetas 
  anidadas ni texto, aunque pueden tener blancos (tabuladores,
  espacios y saltos de línea), comentarios y secciones CDATA.

El contenido de las secciones CDATA se deben ignorar para todas 
las estadísticas (salvo para el conteo de los números de línea).

------------------------------------------------------------------

Ante una entrada como la siguiente.

```xml
<?xml version="1.0" encoding="ISO-8859-1" standalone="no"?>
<!DOCTYPE eje PUBLIC "-//cgosorio//DTD eje//ES" 
                        "http://www.ubu.es/DTD/eje.dtd" >
<!-- Las tres líneas previas no serán procesadas -->

<eje>
  <etiq1 atr1="v1" atr2='val2' atr3="val3" 
         xmlns:pref1="http://admirable-ubu.es">
  texto y mas texto
    <pref1:etiq> </pref1:etiq>  <!-- <== vacío 1 -->
    <pref2:unaEtiq>
       texto
    </pref2:unaEtiq>
  </etiq1> <!-- una etiqueta de cierre-->
  y mira que bueno, incluso mas texto

  <!-- esto es un comentario bastante largo, tiene 
   incluso múltiples líneas -->
  <etiqueta2 attribute1="v1"/>  <!-- un elemento vacío, vacío 2 -->
  <![CDATA[
  <etiq2 > <!-- esta etiqueta y este comentario no los voy a contar
                por estar dentro de una sección CDATA -->
  ]]>

  <ns1:etiq2 xmlns:ns1="http://pisuerga.inf.ubu.es/"
             xmlns:ns2="http://admirable-ubu.es/"
             ns1:at1="val2" ns2:attrib2="val3">
  <!-- este también es un elemento vacío, vacío 3 -->
  </ns1:etiq2>

</eje>
```

Debería dar:
- El comentario más largo empieza en la línea: 17 
- La etiqueta con mayor número de espacios de nombre es: ns1:etiq2
- El atributo con nombre más largo es: attribute1
- El número de elementos vacíos es: 3

