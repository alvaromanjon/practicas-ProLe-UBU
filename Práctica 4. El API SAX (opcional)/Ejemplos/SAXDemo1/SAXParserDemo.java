/*
javac -classpath xercesImpl.jar SAXParserDemo.java
java -cp ".;xercesImpl.jar" SAXParserDemo receta.xml
*/


import java.io.IOException;

//import org.xml.sax.Attributes;
//import org.xml.sax.ContentHandler;
//import org.xml.sax.Locator;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;

// Importar aqu'i la implementaci'on de XMLReader
import org.apache.xerces.parsers.SAXParser;


/**
 * <b><code>SAXParserDemo</code></b> toma un fichero XML y lo analiza
 *   usando SAX, muestra las retrollamdas a lo largo del proceso de an&aacute;lisis
 *
 * @author
 *   <a href="mailto:brettmclaughlin@earthlink.net">Brett McLaughlin</a>
 *   Traducido por <a href="mailto:cgosorio@ubu.es">C&eacute;sar I. G. Osorio</a>
 * @version 1.0
 */
public class SAXParserDemo {

    /**
     * <p>
     *   Analiza el fichero, usando el manipulador SAX registrado, y muestra
     *   los eventos que tienen lugar durante el proceso de an&aacute;lisis.
     * </p>
     *
     * @param uri <code>String</code> URI del fichero a analizar.
     */
    public void ejecutaDemo(String uri) {

        System.out.println("Analizando el fichero: " + uri + "\n\n");

        // instanciar el analizador (parser)
        try {
          XMLReader parser = new SAXParser();
          // hacer que no valide
//          parser.setFeature("http://xml.org/sax/features/validation", false);
	  // analizar el documento
	  parser.parse(uri);
	} catch (IOException e) {
	   System.out.println("Error al leer URI: " + e.getMessage());
        } catch (SAXException e) {
	   System.out.println("Error analizando: " + e.getMessage());
	}
    }

    /**
     * <p>
     *   Proporciona una interfaz de l&iacute;nea de comandos a la demo
     * </p>
     */
    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Uso: java SAXParserDemo [XML URI]");
            System.exit(0);
        }
        String uri = args[0];
        SAXParserDemo parserDemo = new SAXParserDemo();
        parserDemo.ejecutaDemo(uri);
    }
}
