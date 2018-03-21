
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
 *         &lt;element name="DatosP" type="{http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo}ConsultaPedidosEntrada" minOccurs="0"/>
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
    "datosP"
})
@XmlRootElement(name = "ConsultaPedido", namespace = "http://tempuri.org/")
public class ConsultaPedido {

    @XmlElementRef(name = "DatosP", namespace = "http://tempuri.org/", type = JAXBElement.class)
    protected JAXBElement<ConsultaPedidosEntrada> datosP;

    /**
     * Gets the value of the datosP property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link ConsultaPedidosEntrada }{@code >}
     *     
     */
    public JAXBElement<ConsultaPedidosEntrada> getDatosP() {
        return datosP;
    }

    /**
     * Sets the value of the datosP property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link ConsultaPedidosEntrada }{@code >}
     *     
     */
    public void setDatosP(JAXBElement<ConsultaPedidosEntrada> value) {
        this.datosP = ((JAXBElement<ConsultaPedidosEntrada> ) value);
    }

}
