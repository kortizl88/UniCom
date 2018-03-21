
package com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ArrayOfActPedidos complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ArrayOfActPedidos">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ActPedidos" type="{http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo}ActPedidos" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ArrayOfActPedidos", propOrder = {
    "actPedidos"
})
public class ArrayOfActPedidos {

    @XmlElement(name = "ActPedidos", nillable = true)
    protected List<ActPedidos> actPedidos;

    /**
     * Gets the value of the actPedidos property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the actPedidos property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getActPedidos().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ActPedidos }
     * 
     * 
     */
    public List<ActPedidos> getActPedidos() {
        if (actPedidos == null) {
            actPedidos = new ArrayList<ActPedidos>();
        }
        return this.actPedidos;
    }

}
