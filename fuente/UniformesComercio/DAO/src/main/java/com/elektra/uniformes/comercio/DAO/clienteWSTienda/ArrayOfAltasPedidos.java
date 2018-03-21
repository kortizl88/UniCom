
package com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ArrayOfAltasPedidos complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ArrayOfAltasPedidos">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="AltasPedidos" type="{http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo}AltasPedidos" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ArrayOfAltasPedidos", propOrder = {
    "altasPedidos"
})
public class ArrayOfAltasPedidos {

    @XmlElement(name = "AltasPedidos", nillable = true)
    protected List<AltasPedidos> altasPedidos;

    /**
     * Gets the value of the altasPedidos property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the altasPedidos property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAltasPedidos().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link AltasPedidos }
     * 
     * 
     */
    public List<AltasPedidos> getAltasPedidos() {
        if (altasPedidos == null) {
            altasPedidos = new ArrayList<AltasPedidos>();
        }
        return this.altasPedidos;
    }

}
