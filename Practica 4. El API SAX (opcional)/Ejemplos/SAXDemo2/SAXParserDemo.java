import java.io.IOException;

import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.ErrorHandler;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;

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

        // Obtiene las instancias de nuestros manipuladores
        ContentHandler contentHandler = new MyContentHandler();

        try {
            // Instancia un analizador
            XMLReader parser = new SAXParser();

            // Registra el manipulador de contenido
            parser.setContentHandler(contentHandler);

            // Analiza el documento
            parser.parse(uri);

        } catch (IOException e) {
            System.out.println("Error al leer el URI: " + e.getMessage());
        } catch (SAXException e) {
            System.out.println("Error al analizar: " + e.getMessage());
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

/**
 * <b><code>MyContentHandler</code></b> implementa la interfaz SAX
 *   <code>ContentHandler</code> y define el comportamiento de 
 *   las retrollamadas SAX asociadas al contenido del documento
 */
class MyContentHandler implements ContentHandler {

    /** Almacena el locator para la localizaci&oacute;n de informaci&oacute; */
    private Locator locator;

    /**
     * <p>
     * Proporciona una referencia a <code>Locator</code> que suministra
     * informaci&oacute;n sobre en que parte del documento ocurren las 
     * retrollamdas.
     * </p>
     *
     * @param locator <code>Locator</code> objeto vinculado con el
     * proceso de retrollamada
     */
    public void setDocumentLocator(Locator locator) {
        System.out.println(" * setDocumentLocator() invocado");

        // Se almacena para su uso posterior
        this.locator = locator;
    }

    /**
     * <p>
     * Indica el comienzo del an&aacute;lisis de un documento - precede a
     * todas las otras retrollamdas de todos los otros manipuladores SAX con
     * la &uacute;nica excepci&oacute;n de <code>{@link #setDocumentLocator}</code>.
     * </p>
     *
     * @throws <code>SAXException</code>
     */
    public void startDocument() throws SAXException {
        System.out.println("Comienza el an'alisis ...");
    }

    /**
     * <p>
     *   Indica el fin del an&aacute;lisis de un doucmento - ocurre 
     *   despu&eacute;s de todas las otras retrollamadas de los restantes 
     *   manipuladores SAX
     * </p>
     *
     * @throws <code>SAXException</code> 
     */
    public void endDocument() throws SAXException {
        System.out.println("...an'alisis finalizado.");
    }

    /**
     * <p>
     *   Indica que se ha encontrado una instrucci&oacute;n de procesado
     *     distinta de la declaraci&oacute;n XML.
     * </p>
     *
     * @param target <code>String</code> objetivo de la PI
     * @param data <code>String</code> contiene todos los datos enviados a la PI.
     *               Estos normalmente aparecen como uno o m&aacute;s pares
     *               atributo/valor.
     * @throws <code>SAXException</code> 
     */
    public void processingInstruction(String target, String data)
        throws SAXException {

        System.out.println("PI: objetivo:" + target + " y datos:" + data);
    }

    /**
     * <p>
     *   Indica el comienzo de un prefijo de una asignaci&oacute;n a un
     *     prefijo de espacio de nombre. Aunque normalmente esto sucede
     *     dentro del elemento ra&iacute;z de un documento XML, puede 
     *     ocurrir en cualquier otro punto del documneto. Tenga en cuenta
     *     que la invocaci&oacute;n a esta retrollamada tiene lugar
     *     <i>antes</i> que la invocaci&oacute;n a la retrollamada de inicio
     *     del elemento (<code>{@link #startElement}</code>) donde la
     *     asignaci&oacute;n tiene lugar.
     * </p>
     *
     * @param prefix <code>String</code> prefijo usado para el espacio de nombres
     * @param uri <code>String</code> URI del espacio de nombres
     * @throws <code>SAXException</code>
     */
    public void startPrefixMapping(String prefix, String uri) {
        System.out.println("Comienza la asignaci'on de " + prefix +
            " al URI " + uri);
    }

    /**
     * <p>
     *   Indica la finalizaci&oacute;n de la asignaci&oacute;n al prefijo.
     * </p>
     *
     * @param prefix <code>String</code> prefijo del espacio de nombres
     * @throws <code>SAXException</code>
     */
    public void endPrefixMapping(String prefix) {
        System.out.println("Finalizada la asignaci'on de " + prefix);
    }

    /**
     * <p>
     *   Informa de la aparici&oacute;n de un elemento. Suministra
     *     los atributos del elemento, a excepci&oacute;n de los atributos
     *     espec&iacute;ficos del vocabulario XML, como 
     *     <code>xmlns:[prefijo del espacio de nombres]</code> and
     *     <code>xsi:schemaLocation</code>.
     * </p>
     *
     * @param namespaceURI <code>String</code> URI del espacio de nombres al
     *               que esta asociado este elemento, o un <code>String</code>
     *               vac&iacute;o
     * @param localName <code>String</code> nombre del elemento (sin el 
     *               prefijo de espacio de nombres)
     * @param rawName <code>String</code> Versi&oacute;n XML 1.0 del nombre
     *               del elemento:
     *               [prefijo del espacio de nombres]:[nombre local]
     * @param atts <code>Attributes</code> lista de los atributos del elemento
     * @throws <code>SAXException</code> 
     */
    public void startElement(String namespaceURI, String localName,
                                           String rawName, Attributes atts)
        throws SAXException {

        System.out.print("Comienzo del elemento: " + localName);
        if (!namespaceURI.equals("")) {
            System.out.println(" en el espacio de nombres " + namespaceURI +
                " (" + rawName + ")");
        } else {
            System.out.println(" no tiene asociado espacio de nombres");
        }

        for (int i=0; i<atts.getLength(); i++) {
            System.out.println(" Atributo: " + atts.getLocalName(i) +
                "=" + atts.getValue(i));
        }
    }

    /**
     * <p>
     *   Indica el cierre de un elemento, se ha alcanzado una etiqueta
     *     (<code>&lt;/[nombre de elemento]&gt;</code>). El analizador no 
     *     distingue entre etiquetas vacias y no vacias, por lo tanto una 
     *     etiqueta vac&iacute;a ocasionara la inovcaci&oacute; a esta 
     *     retrollamada inmediatamente a continuaci&oacute;n de la invocaci&oacute;n
     *     a (<code>{@link #startElement}</code>)
     * </p>
     *
     * @param namespaceURI <code>String</code> URI del espacio de nombres
     *                con el que este elemento esta asociado
     * @param localName <code>String</code> nombre del elemento sin el prefijo
     * @param rawName <code>String</code> Versi&oacute;n XML 1.0 del nombre del elemento
     * @throws <code>SAXException</code> 
     */
    public void endElement(String namespaceURI, String localName,
                                          String rawName)
        throws SAXException {

        System.out.println("Cierre del elemento: " + localName + "\n");
    }

    /**
     * <p>
     *   Informa de los datos de caracter dentro de un elemento
     * </p>
     *
     * @param ch <code>char[]</code> array de caracteres con los datos de caracter.
     * @param start <code>int</code> &iacute;ndice del array donde comienzan los datos.
     * @param end <code>int</code> &iacute;ndice del array donde acaban los datos.
     * @throws <code>SAXException</code>
     */
    public void characters(char[] ch, int start, int end)
        throws SAXException {

        String s = new String(ch, start, end);
        System.out.println("caracteres: " + s);
    }

    /**
     * <p>
     * Informa de espacios en blanco que se pueden ignorar en 
     * el documento original. Normalmente se invoca s&oacute;lamente
     * cuando se esta validando durante el an&aacute;nalisis.
     * </p>
     *
     * @param ch <code>char[]</code> array de caracteres con los datos de caracter.
     * @param start <code>int</code> &iacute;ndice del array donde comienzan los datos.
     * @param end <code>int</code> &iacute;ndice del array donde acaban los datos.
     * @throws <code>SAXException</code>
     */
    public void ignorableWhitespace(char[] ch, int start, int end)
        throws SAXException {

        String s = new String(ch, start, end);
        System.out.println("espacios ignorables: [" + s + "]");
    }

    /**
     * <p>
     *    Informa de una entidad que ha sido obviada por el analizador.
     *      Esta retrollamda s&oacute;lamente tendr&aacute; lugar para los
     *      analizadores no validantes, y en cualquier caso es algo en lo
     *      que el dise&ntilde;ador del analizador tiene libertad.
     * </p>
     *
     * @param name <code>String</code> nombre de la entidad no analizada
     * @throws <code>SAXException</code>
     */
    public void skippedEntity(String name) throws SAXException {
        System.out.println("Omitiendo la entidad " + name);
    }
}
