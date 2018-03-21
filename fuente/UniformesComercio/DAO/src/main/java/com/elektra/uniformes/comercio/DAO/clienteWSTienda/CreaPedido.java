
package com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for CreaPedido complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CreaPedido">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="AltaPed" type="{http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo}ArrayOfAltasPedidos" minOccurs="0"/>
 *         &lt;element name="BanderaError" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="msjSalida" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CreaPedido", propOrder = {
    "altaPed",
    "banderaError",
    "msjSalida"
})
public class CreaPedido {

    @XmlElementRef(name = "AltaPed", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<ArrayOfAltasPedidos> altaPed;
    @XmlElement(name = "BanderaError")
    protected Integer banderaError;
    @XmlElementRef(name = "msjSalida", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<String> msjSalida;

    /**
     * Gets the value of the altaPed property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link ArrayOfAltasPedidos }{@code >}
     *     
     */
    public JAXBElement<ArrayOfAltasPedidos> getAltaPed() {
        return altaPed;
    }

    /**
     * Sets the value of the altaPed property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link ArrayOfAltasPedidos }{@code >}
     *     
     */
    public void setAltaPed(JAXBElement<ArrayOfAltasPedidos> value) {
        this.altaPed = ((JAXBElement<ArrayOfAltasPedidos> ) value);
    }

    /**
     * Gets the value of the banderaError property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getBanderaError() {
        return banderaError;
    }

    /**
     * Sets the value of the banderaError property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setBanderaError(Integer value) {
        this.banderaError = value;
    }

    /**
     * Gets the value of the msjSalida property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getMsjSalida() {
        return msjSalida;
    }

    /**
     * Sets the value of the msjSalida property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setMsjSalida(JAXBElement<String> value) {
        this.msjSalida = ((JAXBElement<String> ) value);
    }

}
