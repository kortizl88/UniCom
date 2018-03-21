
package com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="Recive" type="{http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo}ReciveDatos" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "recive"
})
@XmlRootElement(name = "GeneraPedido", namespace = "http://tempuri.org/")
public class GeneraPedido {

    @XmlElementRef(name = "Recive", namespace = "http://tempuri.org/", type = JAXBElement.class)
    protected JAXBElement<ReciveDatos> recive;

    /**
     * Gets the value of the recive property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link ReciveDatos }{@code >}
     *     
     */
    public JAXBElement<ReciveDatos> getRecive() {
        return recive;
    }

    /**
     * Sets the value of the recive property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link ReciveDatos }{@code >}
     *     
     */
    public void setRecive(JAXBElement<ReciveDatos> value) {
        this.recive = ((JAXBElement<ReciveDatos> ) value);
    }

}
