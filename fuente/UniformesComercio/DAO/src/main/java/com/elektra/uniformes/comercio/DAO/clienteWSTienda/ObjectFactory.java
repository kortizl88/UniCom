
package com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda;

import java.math.BigDecimal;
import java.math.BigInteger;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.datatype.Duration;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _AnyURI_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "anyURI");
    private final static QName _Char_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "char");
    private final static QName _DateTime_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "dateTime");
    private final static QName _QName_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "QName");
    private final static QName _ConsultaPedidos_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "ConsultaPedidos");
    private final static QName _UnsignedShort_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "unsignedShort");
    private final static QName _Float_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "float");
    private final static QName _Long_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "long");
    private final static QName _ConsPedido_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "ConsPedido");
    private final static QName _Short_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "short");
    private final static QName _Base64Binary_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "base64Binary");
    private final static QName _Byte_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "byte");
    private final static QName _AltasPedidos_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "AltasPedidos");
    private final static QName _ArrayOfDetalleSKU_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "ArrayOfDetalleSKU");
    private final static QName _ArrayOfAltasPedidos_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "ArrayOfAltasPedidos");
    private final static QName _DetalleSKU_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "DetalleSKU");
    private final static QName _ArrayOfActPedidos_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "ArrayOfActPedidos");
    private final static QName _Boolean_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "boolean");
    private final static QName _ConsultaPedidosEntrada_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "ConsultaPedidosEntrada");
    private final static QName _ActPedidos_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "ActPedidos");
    private final static QName _SalidaDatos_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "SalidaDatos");
    private final static QName _UnsignedByte_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "unsignedByte");
    private final static QName _AnyType_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "anyType");
    private final static QName _UnsignedInt_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "unsignedInt");
    private final static QName _ArrayOfConsPedido_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "ArrayOfConsPedido");
    private final static QName _Int_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "int");
    private final static QName _ReciveDatos_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "ReciveDatos");
    private final static QName _Decimal_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "decimal");
    private final static QName _Double_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "double");
    private final static QName _Guid_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "guid");
    private final static QName _Duration_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "duration");
    private final static QName _AtualizaPedidos_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "AtualizaPedidos");
    private final static QName _CreaPedido_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "CreaPedido");
    private final static QName _ArrayOfint_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/Arrays", "ArrayOfint");
    private final static QName _String_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "string");
    private final static QName _UnsignedLong_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/", "unsignedLong");
    private final static QName _ArrayOfKeyValueOfstringstring_QNAME = new QName("http://schemas.microsoft.com/2003/10/Serialization/Arrays", "ArrayOfKeyValueOfstringstring");
    private final static QName _AtualizaPedidosModifPed_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "ModifPed");
    private final static QName _AtualizaPedidosKeyWs_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "KeyWs");
    private final static QName _ActPedidosNumEmpleado_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "NumEmpleado");
    private final static QName _ActPedidosObservaciones_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "Observaciones");
    private final static QName _ActPedidosSKU_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "SKU");
    private final static QName _CreaPedidoAltaPed_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "AltaPed");
    private final static QName _CreaPedidoMsjSalida_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "msjSalida");
    private final static QName _ReciveDatosSku_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "Sku");
    private final static QName _ReciveDatosNumTienda_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "NumTienda");
    private final static QName _ReciveDatosEmpleado_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "Empleado");
    private final static QName _ReciveDatosNoEmpIngreso_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "NoEmpIngreso");
    private final static QName _ConsultaParametrosResponseConsultaParametrosResult_QNAME = new QName("http://tempuri.org/", "ConsultaParametrosResult");
    private final static QName _ConsultaPedidosConsulPedidos_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "ConsulPedidos");
    private final static QName _GeneraPedidoRecive_QNAME = new QName("http://tempuri.org/", "Recive");
    private final static QName _ConsPedidoNoTienda_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "NoTienda");
    private final static QName _ConsPedidoSKUDetalle_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "SKUDetalle");
    private final static QName _ConsultaPedidoDatosP_QNAME = new QName("http://tempuri.org/", "DatosP");
    private final static QName _ConsultaPedidoResponseConsultaPedidoResult_QNAME = new QName("http://tempuri.org/", "ConsultaPedidoResult");
    private final static QName _GeneraPedidoResponseGeneraPedidoResult_QNAME = new QName("http://tempuri.org/", "GeneraPedidoResult");
    private final static QName _DetalleSKUEmpRemision_QNAME = new QName("http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", "EmpRemision");
    private final static QName _ActualizaPedidoResponseActualizaPedidoResult_QNAME = new QName("http://tempuri.org/", "ActualizaPedidoResult");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link ConsultaParametros }
     * 
     */
    public ConsultaParametros createConsultaParametros() {
        return new ConsultaParametros();
    }

    /**
     * Create an instance of {@link ActPedidos }
     * 
     */
    public ActPedidos createActPedidos() {
        return new ActPedidos();
    }

    /**
     * Create an instance of {@link ReciveDatos }
     * 
     */
    public ReciveDatos createReciveDatos() {
        return new ReciveDatos();
    }

    /**
     * Create an instance of {@link ConsPedido }
     * 
     */
    public ConsPedido createConsPedido() {
        return new ConsPedido();
    }

    /**
     * Create an instance of {@link ConsultaPedido }
     * 
     */
    public ConsultaPedido createConsultaPedido() {
        return new ConsultaPedido();
    }

    /**
     * Create an instance of {@link GeneraPedidoResponse }
     * 
     */
    public GeneraPedidoResponse createGeneraPedidoResponse() {
        return new GeneraPedidoResponse();
    }

    /**
     * Create an instance of {@link ArrayOfDetalleSKU }
     * 
     */
    public ArrayOfDetalleSKU createArrayOfDetalleSKU() {
        return new ArrayOfDetalleSKU();
    }

    /**
     * Create an instance of {@link SalidaDatos }
     * 
     */
    public SalidaDatos createSalidaDatos() {
        return new SalidaDatos();
    }

    /**
     * Create an instance of {@link ArrayOfKeyValueOfstringstring }
     * 
     */
    public ArrayOfKeyValueOfstringstring createArrayOfKeyValueOfstringstring() {
        return new ArrayOfKeyValueOfstringstring();
    }

    /**
     * Create an instance of {@link ArrayOfKeyValueOfstringstring.KeyValueOfstringstring }
     * 
     */
    public ArrayOfKeyValueOfstringstring.KeyValueOfstringstring createArrayOfKeyValueOfstringstringKeyValueOfstringstring() {
        return new ArrayOfKeyValueOfstringstring.KeyValueOfstringstring();
    }

    /**
     * Create an instance of {@link ActualizaPedidoResponse }
     * 
     */
    public ActualizaPedidoResponse createActualizaPedidoResponse() {
        return new ActualizaPedidoResponse();
    }

    /**
     * Create an instance of {@link ArrayOfActPedidos }
     * 
     */
    public ArrayOfActPedidos createArrayOfActPedidos() {
        return new ArrayOfActPedidos();
    }

    /**
     * Create an instance of {@link AltasPedidos }
     * 
     */
    public AltasPedidos createAltasPedidos() {
        return new AltasPedidos();
    }

    /**
     * Create an instance of {@link ConsultaPedidosEntrada }
     * 
     */
    public ConsultaPedidosEntrada createConsultaPedidosEntrada() {
        return new ConsultaPedidosEntrada();
    }

    /**
     * Create an instance of {@link AtualizaPedidos }
     * 
     */
    public AtualizaPedidos createAtualizaPedidos() {
        return new AtualizaPedidos();
    }

    /**
     * Create an instance of {@link CreaPedido }
     * 
     */
    public CreaPedido createCreaPedido() {
        return new CreaPedido();
    }

    /**
     * Create an instance of {@link ConsultaParametrosResponse }
     * 
     */
    public ConsultaParametrosResponse createConsultaParametrosResponse() {
        return new ConsultaParametrosResponse();
    }

    /**
     * Create an instance of {@link ConsultaPedidos }
     * 
     */
    public ConsultaPedidos createConsultaPedidos() {
        return new ConsultaPedidos();
    }

    /**
     * Create an instance of {@link GeneraPedido }
     * 
     */
    public GeneraPedido createGeneraPedido() {
        return new GeneraPedido();
    }

    /**
     * Create an instance of {@link ConsultaPedidoResponse }
     * 
     */
    public ConsultaPedidoResponse createConsultaPedidoResponse() {
        return new ConsultaPedidoResponse();
    }

    /**
     * Create an instance of {@link ActualizaPedido }
     * 
     */
    public ActualizaPedido createActualizaPedido() {
        return new ActualizaPedido();
    }

    /**
     * Create an instance of {@link DetalleSKU }
     * 
     */
    public DetalleSKU createDetalleSKU() {
        return new DetalleSKU();
    }

    /**
     * Create an instance of {@link ArrayOfint }
     * 
     */
    public ArrayOfint createArrayOfint() {
        return new ArrayOfint();
    }

    /**
     * Create an instance of {@link ArrayOfConsPedido }
     * 
     */
    public ArrayOfConsPedido createArrayOfConsPedido() {
        return new ArrayOfConsPedido();
    }

    /**
     * Create an instance of {@link ArrayOfAltasPedidos }
     * 
     */
    public ArrayOfAltasPedidos createArrayOfAltasPedidos() {
        return new ArrayOfAltasPedidos();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "anyURI")
    public JAXBElement<String> createAnyURI(String value) {
        return new JAXBElement<String>(_AnyURI_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Integer }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "char")
    public JAXBElement<Integer> createChar(Integer value) {
        return new JAXBElement<Integer>(_Char_QNAME, Integer.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link XMLGregorianCalendar }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "dateTime")
    public JAXBElement<XMLGregorianCalendar> createDateTime(XMLGregorianCalendar value) {
        return new JAXBElement<XMLGregorianCalendar>(_DateTime_QNAME, XMLGregorianCalendar.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link QName }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "QName")
    public JAXBElement<QName> createQName(QName value) {
        return new JAXBElement<QName>(_QName_QNAME, QName.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ConsultaPedidos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ConsultaPedidos")
    public JAXBElement<ConsultaPedidos> createConsultaPedidos(ConsultaPedidos value) {
        return new JAXBElement<ConsultaPedidos>(_ConsultaPedidos_QNAME, ConsultaPedidos.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Integer }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "unsignedShort")
    public JAXBElement<Integer> createUnsignedShort(Integer value) {
        return new JAXBElement<Integer>(_UnsignedShort_QNAME, Integer.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Float }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "float")
    public JAXBElement<Float> createFloat(Float value) {
        return new JAXBElement<Float>(_Float_QNAME, Float.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Long }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "long")
    public JAXBElement<Long> createLong(Long value) {
        return new JAXBElement<Long>(_Long_QNAME, Long.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ConsPedido }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ConsPedido")
    public JAXBElement<ConsPedido> createConsPedido(ConsPedido value) {
        return new JAXBElement<ConsPedido>(_ConsPedido_QNAME, ConsPedido.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Short }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "short")
    public JAXBElement<Short> createShort(Short value) {
        return new JAXBElement<Short>(_Short_QNAME, Short.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link byte[]}{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "base64Binary")
    public JAXBElement<byte[]> createBase64Binary(byte[] value) {
        return new JAXBElement<byte[]>(_Base64Binary_QNAME, byte[].class, null, ((byte[]) value));
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Byte }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "byte")
    public JAXBElement<Byte> createByte(Byte value) {
        return new JAXBElement<Byte>(_Byte_QNAME, Byte.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AltasPedidos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "AltasPedidos")
    public JAXBElement<AltasPedidos> createAltasPedidos(AltasPedidos value) {
        return new JAXBElement<AltasPedidos>(_AltasPedidos_QNAME, AltasPedidos.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfDetalleSKU }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ArrayOfDetalleSKU")
    public JAXBElement<ArrayOfDetalleSKU> createArrayOfDetalleSKU(ArrayOfDetalleSKU value) {
        return new JAXBElement<ArrayOfDetalleSKU>(_ArrayOfDetalleSKU_QNAME, ArrayOfDetalleSKU.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfAltasPedidos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ArrayOfAltasPedidos")
    public JAXBElement<ArrayOfAltasPedidos> createArrayOfAltasPedidos(ArrayOfAltasPedidos value) {
        return new JAXBElement<ArrayOfAltasPedidos>(_ArrayOfAltasPedidos_QNAME, ArrayOfAltasPedidos.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link DetalleSKU }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "DetalleSKU")
    public JAXBElement<DetalleSKU> createDetalleSKU(DetalleSKU value) {
        return new JAXBElement<DetalleSKU>(_DetalleSKU_QNAME, DetalleSKU.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfActPedidos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ArrayOfActPedidos")
    public JAXBElement<ArrayOfActPedidos> createArrayOfActPedidos(ArrayOfActPedidos value) {
        return new JAXBElement<ArrayOfActPedidos>(_ArrayOfActPedidos_QNAME, ArrayOfActPedidos.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Boolean }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "boolean")
    public JAXBElement<Boolean> createBoolean(Boolean value) {
        return new JAXBElement<Boolean>(_Boolean_QNAME, Boolean.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ConsultaPedidosEntrada }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ConsultaPedidosEntrada")
    public JAXBElement<ConsultaPedidosEntrada> createConsultaPedidosEntrada(ConsultaPedidosEntrada value) {
        return new JAXBElement<ConsultaPedidosEntrada>(_ConsultaPedidosEntrada_QNAME, ConsultaPedidosEntrada.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ActPedidos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ActPedidos")
    public JAXBElement<ActPedidos> createActPedidos(ActPedidos value) {
        return new JAXBElement<ActPedidos>(_ActPedidos_QNAME, ActPedidos.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SalidaDatos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "SalidaDatos")
    public JAXBElement<SalidaDatos> createSalidaDatos(SalidaDatos value) {
        return new JAXBElement<SalidaDatos>(_SalidaDatos_QNAME, SalidaDatos.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Short }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "unsignedByte")
    public JAXBElement<Short> createUnsignedByte(Short value) {
        return new JAXBElement<Short>(_UnsignedByte_QNAME, Short.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Object }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "anyType")
    public JAXBElement<Object> createAnyType(Object value) {
        return new JAXBElement<Object>(_AnyType_QNAME, Object.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Long }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "unsignedInt")
    public JAXBElement<Long> createUnsignedInt(Long value) {
        return new JAXBElement<Long>(_UnsignedInt_QNAME, Long.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfConsPedido }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ArrayOfConsPedido")
    public JAXBElement<ArrayOfConsPedido> createArrayOfConsPedido(ArrayOfConsPedido value) {
        return new JAXBElement<ArrayOfConsPedido>(_ArrayOfConsPedido_QNAME, ArrayOfConsPedido.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Integer }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "int")
    public JAXBElement<Integer> createInt(Integer value) {
        return new JAXBElement<Integer>(_Int_QNAME, Integer.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ReciveDatos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ReciveDatos")
    public JAXBElement<ReciveDatos> createReciveDatos(ReciveDatos value) {
        return new JAXBElement<ReciveDatos>(_ReciveDatos_QNAME, ReciveDatos.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigDecimal }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "decimal")
    public JAXBElement<BigDecimal> createDecimal(BigDecimal value) {
        return new JAXBElement<BigDecimal>(_Decimal_QNAME, BigDecimal.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Double }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "double")
    public JAXBElement<Double> createDouble(Double value) {
        return new JAXBElement<Double>(_Double_QNAME, Double.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "guid")
    public JAXBElement<String> createGuid(String value) {
        return new JAXBElement<String>(_Guid_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Duration }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "duration")
    public JAXBElement<Duration> createDuration(Duration value) {
        return new JAXBElement<Duration>(_Duration_QNAME, Duration.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AtualizaPedidos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "AtualizaPedidos")
    public JAXBElement<AtualizaPedidos> createAtualizaPedidos(AtualizaPedidos value) {
        return new JAXBElement<AtualizaPedidos>(_AtualizaPedidos_QNAME, AtualizaPedidos.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CreaPedido }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "CreaPedido")
    public JAXBElement<CreaPedido> createCreaPedido(CreaPedido value) {
        return new JAXBElement<CreaPedido>(_CreaPedido_QNAME, CreaPedido.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfint }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/Arrays", name = "ArrayOfint")
    public JAXBElement<ArrayOfint> createArrayOfint(ArrayOfint value) {
        return new JAXBElement<ArrayOfint>(_ArrayOfint_QNAME, ArrayOfint.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "string")
    public JAXBElement<String> createString(String value) {
        return new JAXBElement<String>(_String_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/", name = "unsignedLong")
    public JAXBElement<BigInteger> createUnsignedLong(BigInteger value) {
        return new JAXBElement<BigInteger>(_UnsignedLong_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfKeyValueOfstringstring }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.microsoft.com/2003/10/Serialization/Arrays", name = "ArrayOfKeyValueOfstringstring")
    public JAXBElement<ArrayOfKeyValueOfstringstring> createArrayOfKeyValueOfstringstring(ArrayOfKeyValueOfstringstring value) {
        return new JAXBElement<ArrayOfKeyValueOfstringstring>(_ArrayOfKeyValueOfstringstring_QNAME, ArrayOfKeyValueOfstringstring.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfActPedidos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ModifPed", scope = AtualizaPedidos.class)
    public JAXBElement<ArrayOfActPedidos> createAtualizaPedidosModifPed(ArrayOfActPedidos value) {
        return new JAXBElement<ArrayOfActPedidos>(_AtualizaPedidosModifPed_QNAME, ArrayOfActPedidos.class, AtualizaPedidos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "KeyWs", scope = AtualizaPedidos.class)
    public JAXBElement<String> createAtualizaPedidosKeyWs(String value) {
        return new JAXBElement<String>(_AtualizaPedidosKeyWs_QNAME, String.class, AtualizaPedidos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "NumEmpleado", scope = ActPedidos.class)
    public JAXBElement<String> createActPedidosNumEmpleado(String value) {
        return new JAXBElement<String>(_ActPedidosNumEmpleado_QNAME, String.class, ActPedidos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "Observaciones", scope = ActPedidos.class)
    public JAXBElement<String> createActPedidosObservaciones(String value) {
        return new JAXBElement<String>(_ActPedidosObservaciones_QNAME, String.class, ActPedidos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfint }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "SKU", scope = ActPedidos.class)
    public JAXBElement<ArrayOfint> createActPedidosSKU(ArrayOfint value) {
        return new JAXBElement<ArrayOfint>(_ActPedidosSKU_QNAME, ArrayOfint.class, ActPedidos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfAltasPedidos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "AltaPed", scope = CreaPedido.class)
    public JAXBElement<ArrayOfAltasPedidos> createCreaPedidoAltaPed(ArrayOfAltasPedidos value) {
        return new JAXBElement<ArrayOfAltasPedidos>(_CreaPedidoAltaPed_QNAME, ArrayOfAltasPedidos.class, CreaPedido.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "msjSalida", scope = CreaPedido.class)
    public JAXBElement<String> createCreaPedidoMsjSalida(String value) {
        return new JAXBElement<String>(_CreaPedidoMsjSalida_QNAME, String.class, CreaPedido.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfint }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "Sku", scope = ReciveDatos.class)
    public JAXBElement<ArrayOfint> createReciveDatosSku(ArrayOfint value) {
        return new JAXBElement<ArrayOfint>(_ReciveDatosSku_QNAME, ArrayOfint.class, ReciveDatos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "NumTienda", scope = ReciveDatos.class)
    public JAXBElement<String> createReciveDatosNumTienda(String value) {
        return new JAXBElement<String>(_ReciveDatosNumTienda_QNAME, String.class, ReciveDatos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "Empleado", scope = ReciveDatos.class)
    public JAXBElement<String> createReciveDatosEmpleado(String value) {
        return new JAXBElement<String>(_ReciveDatosEmpleado_QNAME, String.class, ReciveDatos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "NoEmpIngreso", scope = ReciveDatos.class)
    public JAXBElement<String> createReciveDatosNoEmpIngreso(String value) {
        return new JAXBElement<String>(_ReciveDatosNoEmpIngreso_QNAME, String.class, ReciveDatos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "KeyWs", scope = ReciveDatos.class)
    public JAXBElement<String> createReciveDatosKeyWs(String value) {
        return new JAXBElement<String>(_AtualizaPedidosKeyWs_QNAME, String.class, ReciveDatos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfKeyValueOfstringstring }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://tempuri.org/", name = "ConsultaParametrosResult", scope = ConsultaParametrosResponse.class)
    public JAXBElement<ArrayOfKeyValueOfstringstring> createConsultaParametrosResponseConsultaParametrosResult(ArrayOfKeyValueOfstringstring value) {
        return new JAXBElement<ArrayOfKeyValueOfstringstring>(_ConsultaParametrosResponseConsultaParametrosResult_QNAME, ArrayOfKeyValueOfstringstring.class, ConsultaParametrosResponse.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfConsPedido }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ConsulPedidos", scope = ConsultaPedidos.class)
    public JAXBElement<ArrayOfConsPedido> createConsultaPedidosConsulPedidos(ArrayOfConsPedido value) {
        return new JAXBElement<ArrayOfConsPedido>(_ConsultaPedidosConsulPedidos_QNAME, ArrayOfConsPedido.class, ConsultaPedidos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "msjSalida", scope = ConsultaPedidos.class)
    public JAXBElement<String> createConsultaPedidosMsjSalida(String value) {
        return new JAXBElement<String>(_CreaPedidoMsjSalida_QNAME, String.class, ConsultaPedidos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ReciveDatos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://tempuri.org/", name = "Recive", scope = GeneraPedido.class)
    public JAXBElement<ReciveDatos> createGeneraPedidoRecive(ReciveDatos value) {
        return new JAXBElement<ReciveDatos>(_GeneraPedidoRecive_QNAME, ReciveDatos.class, GeneraPedido.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "NumEmpleado", scope = ConsPedido.class)
    public JAXBElement<String> createConsPedidoNumEmpleado(String value) {
        return new JAXBElement<String>(_ActPedidosNumEmpleado_QNAME, String.class, ConsPedido.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "NoTienda", scope = ConsPedido.class)
    public JAXBElement<String> createConsPedidoNoTienda(String value) {
        return new JAXBElement<String>(_ConsPedidoNoTienda_QNAME, String.class, ConsPedido.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfDetalleSKU }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "SKUDetalle", scope = ConsPedido.class)
    public JAXBElement<ArrayOfDetalleSKU> createConsPedidoSKUDetalle(ArrayOfDetalleSKU value) {
        return new JAXBElement<ArrayOfDetalleSKU>(_ConsPedidoSKUDetalle_QNAME, ArrayOfDetalleSKU.class, ConsPedido.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ConsultaPedidosEntrada }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://tempuri.org/", name = "DatosP", scope = ConsultaPedido.class)
    public JAXBElement<ConsultaPedidosEntrada> createConsultaPedidoDatosP(ConsultaPedidosEntrada value) {
        return new JAXBElement<ConsultaPedidosEntrada>(_ConsultaPedidoDatosP_QNAME, ConsultaPedidosEntrada.class, ConsultaPedido.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ConsultaPedidos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://tempuri.org/", name = "ConsultaPedidoResult", scope = ConsultaPedidoResponse.class)
    public JAXBElement<ConsultaPedidos> createConsultaPedidoResponseConsultaPedidoResult(ConsultaPedidos value) {
        return new JAXBElement<ConsultaPedidos>(_ConsultaPedidoResponseConsultaPedidoResult_QNAME, ConsultaPedidos.class, ConsultaPedidoResponse.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CreaPedido }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://tempuri.org/", name = "GeneraPedidoResult", scope = GeneraPedidoResponse.class)
    public JAXBElement<CreaPedido> createGeneraPedidoResponseGeneraPedidoResult(CreaPedido value) {
        return new JAXBElement<CreaPedido>(_GeneraPedidoResponseGeneraPedidoResult_QNAME, CreaPedido.class, GeneraPedidoResponse.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AtualizaPedidos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://tempuri.org/", name = "DatosP", scope = ActualizaPedido.class)
    public JAXBElement<AtualizaPedidos> createActualizaPedidoDatosP(AtualizaPedidos value) {
        return new JAXBElement<AtualizaPedidos>(_ConsultaPedidoDatosP_QNAME, AtualizaPedidos.class, ActualizaPedido.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "msjSalida", scope = SalidaDatos.class)
    public JAXBElement<String> createSalidaDatosMsjSalida(String value) {
        return new JAXBElement<String>(_CreaPedidoMsjSalida_QNAME, String.class, SalidaDatos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "EmpRemision", scope = DetalleSKU.class)
    public JAXBElement<String> createDetalleSKUEmpRemision(String value) {
        return new JAXBElement<String>(_DetalleSKUEmpRemision_QNAME, String.class, DetalleSKU.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SalidaDatos }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://tempuri.org/", name = "ActualizaPedidoResult", scope = ActualizaPedidoResponse.class)
    public JAXBElement<SalidaDatos> createActualizaPedidoResponseActualizaPedidoResult(SalidaDatos value) {
        return new JAXBElement<SalidaDatos>(_ActualizaPedidoResponseActualizaPedidoResult_QNAME, SalidaDatos.class, ActualizaPedidoResponse.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "NoTienda", scope = AltasPedidos.class)
    public JAXBElement<String> createAltasPedidosNoTienda(String value) {
        return new JAXBElement<String>(_ConsPedidoNoTienda_QNAME, String.class, AltasPedidos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "Empleado", scope = AltasPedidos.class)
    public JAXBElement<String> createAltasPedidosEmpleado(String value) {
        return new JAXBElement<String>(_ReciveDatosEmpleado_QNAME, String.class, AltasPedidos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ArrayOfint }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "SKU", scope = AltasPedidos.class)
    public JAXBElement<ArrayOfint> createAltasPedidosSKU(ArrayOfint value) {
        return new JAXBElement<ArrayOfint>(_ActPedidosSKU_QNAME, ArrayOfint.class, AltasPedidos.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", name = "ConsulPedidos", scope = ConsultaPedidosEntrada.class)
    public JAXBElement<String> createConsultaPedidosEntradaConsulPedidos(String value) {
        return new JAXBElement<String>(_ConsultaPedidosConsulPedidos_QNAME, String.class, ConsultaPedidosEntrada.class, value);
    }

}
