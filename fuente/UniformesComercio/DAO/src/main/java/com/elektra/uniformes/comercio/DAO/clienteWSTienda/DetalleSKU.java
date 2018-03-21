
package com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for DetalleSKU complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="DetalleSKU">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="EmpRemision" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="NumRemision" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="SKU" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DetalleSKU", propOrder = {
    "empRemision",
    "numRemision",
    "sku"
})
public class DetalleSKU {

    @XmlElementRef(name = "EmpRemision", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<String> empRemision;
    @XmlElement(name = "NumRemision")
    protected Integer numRemision;
    @XmlElement(name = "SKU")
    protected Integer sku;

    /**
     * Gets the value of the empRemision property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getEmpRemision() {
        return empRemision;
    }

    /**
     * Sets the value of the empRemision property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setEmpRemision(JAXBElement<String> value) {
        this.empRemision = ((JAXBElement<String> ) value);
    }

    /**
     * Gets the value of the numRemision property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getNumRemision() {
        return numRemision;
    }

    /**
     * Sets the value of the numRemision property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setNumRemision(Integer value) {
        this.numRemision = value;
    }

    /**
     * Gets the value of the sku property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getSKU() {
        return sku;
    }

    /**
     * Sets the value of the sku property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setSKU(Integer value) {
        this.sku = value;
    }

}
