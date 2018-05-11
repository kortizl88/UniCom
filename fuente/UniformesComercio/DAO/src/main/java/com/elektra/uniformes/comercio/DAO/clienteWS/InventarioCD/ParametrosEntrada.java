
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
 *         &lt;element name="Tienda" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="Sku" type="{http://www.w3.org/2001/XMLSchema}string"/>
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
    "tienda",
    "sku"
})
@XmlRootElement(name = "Parametros_Entrada", namespace = "http://esquemas.elektra.com.mx/ekt/1.0/Esq_Entr_Inventario")
public class ParametrosEntrada {

    @XmlElement(name = "Tienda", namespace = "http://esquemas.elektra.com.mx/ekt/1.0/Esq_Entr_Inventario", required = true)
    protected String tienda;
    @XmlElement(name = "Sku", namespace = "http://esquemas.elektra.com.mx/ekt/1.0/Esq_Entr_Inventario", required = true)
    protected String sku;

    /**
     * Gets the value of the tienda property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTienda() {
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
    public void setTienda(String value) {
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
    public String getSku() {
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
    public void setSku(String value) {
        this.sku = value;
    }

}
