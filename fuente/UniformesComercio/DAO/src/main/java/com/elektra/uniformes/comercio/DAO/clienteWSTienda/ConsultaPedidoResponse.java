
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
 *         &lt;element name="ConsultaPedidoResult" type="{http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo}ConsultaPedidos" minOccurs="0"/>
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
    "consultaPedidoResult"
})
@XmlRootElement(name = "ConsultaPedidoResponse", namespace = "http://tempuri.org/")
public class ConsultaPedidoResponse {

    @XmlElementRef(name = "ConsultaPedidoResult", namespace = "http://tempuri.org/", type = JAXBElement.class)
    protected JAXBElement<ConsultaPedidos> consultaPedidoResult;

    /**
     * Gets the value of the consultaPedidoResult property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link ConsultaPedidos }{@code >}
     *     
     */
    public JAXBElement<ConsultaPedidos> getConsultaPedidoResult() {
        return consultaPedidoResult;
    }

    /**
     * Sets the value of the consultaPedidoResult property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link ConsultaPedidos }{@code >}
     *     
     */
    public void setConsultaPedidoResult(JAXBElement<ConsultaPedidos> value) {
        this.consultaPedidoResult = ((JAXBElement<ConsultaPedidos> ) value);
    }

}
