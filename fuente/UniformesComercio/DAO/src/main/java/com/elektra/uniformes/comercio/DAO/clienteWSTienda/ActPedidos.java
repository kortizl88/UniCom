
package com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ActPedidos complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ActPedidos">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="NumEmpleado" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="NumPedido" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="Observaciones" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="SKU" type="{http://schemas.microsoft.com/2003/10/Serialization/Arrays}ArrayOfint" minOccurs="0"/>
 *         &lt;element name="Status" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ActPedidos", propOrder = {
    "numEmpleado",
    "numPedido",
    "observaciones",
    "sku",
    "status"
})
public class ActPedidos {

    @XmlElementRef(name = "NumEmpleado", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<String> numEmpleado;
    @XmlElement(name = "NumPedido")
    protected Integer numPedido;
    @XmlElementRef(name = "Observaciones", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<String> observaciones;
    @XmlElementRef(name = "SKU", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<ArrayOfint> sku;
    @XmlElement(name = "Status")
    protected Integer status;

    /**
     * Gets the value of the numEmpleado property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getNumEmpleado() {
        return numEmpleado;
    }

    /**
     * Sets the value of the numEmpleado property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setNumEmpleado(JAXBElement<String> value) {
        this.numEmpleado = ((JAXBElement<String> ) value);
    }

    /**
     * Gets the value of the numPedido property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getNumPedido() {
        return numPedido;
    }

    /**
     * Sets the value of the numPedido property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setNumPedido(Integer value) {
        this.numPedido = value;
    }

    /**
     * Gets the value of the observaciones property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getObservaciones() {
        return observaciones;
    }

    /**
     * Sets the value of the observaciones property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setObservaciones(JAXBElement<String> value) {
        this.observaciones = ((JAXBElement<String> ) value);
    }

    /**
     * Gets the value of the sku property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link ArrayOfint }{@code >}
     *     
     */
    public JAXBElement<ArrayOfint> getSKU() {
        return sku;
    }

    /**
     * Sets the value of the sku property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link ArrayOfint }{@code >}
     *     
     */
    public void setSKU(JAXBElement<ArrayOfint> value) {
        this.sku = ((JAXBElement<ArrayOfint> ) value);
    }

    /**
     * Gets the value of the status property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getStatus() {
        return status;
    }

    /**
     * Sets the value of the status property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setStatus(Integer value) {
        this.status = value;
    }

}
