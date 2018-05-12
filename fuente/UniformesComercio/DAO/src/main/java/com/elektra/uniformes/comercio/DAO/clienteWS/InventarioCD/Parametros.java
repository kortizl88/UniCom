
package com.elektra.uniformes.comercio.DAO.clienteWS.InventarioCD;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
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
 *         &lt;element name="ALMAC" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="TIENDA" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="SKU" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="QTY" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="MSG" type="{http://www.w3.org/2001/XMLSchema}string"/>
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
    "almac",
    "tienda",
    "sku",
    "qty",
    "msg"
})
@XmlRootElement(name = "Parametros")
public class Parametros {

    @XmlElement(name = "ALMAC", required = true)
    protected String almac;
    @XmlElement(name = "TIENDA", required = true)
    protected String tienda;
    @XmlElement(name = "SKU", required = true)
    protected String sku;
    @XmlElement(name = "QTY", required = true)
    protected String qty;
    @XmlElement(name = "MSG", required = true)
    protected String msg;

    /**
     * Gets the value of the almac property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getALMAC() {
        return almac;
    }

    /**
     * Sets the value of the almac property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setALMAC(String value) {
        this.almac = value;
    }

    /**
     * Gets the value of the tienda property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTIENDA() {
        return tienda;
    }

    /**
     * Sets the value of the tienda property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTIENDA(String value) {
        this.tienda = value;
    }

    /**
     * Gets the value of the sku property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSKU() {
        return sku;
    }

    /**
     * Sets the value of the sku property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSKU(String value) {
        this.sku = value;
    }

    /**
     * Gets the value of the qty property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getQTY() {
        return qty;
    }

    /**
     * Sets the value of the qty property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setQTY(String value) {
        this.qty = value;
    }

    /**
     * Gets the value of the msg property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMSG() {
        return msg;
    }

    /**
     * Sets the value of the msg property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMSG(String value) {
        this.msg = value;
    }

}
