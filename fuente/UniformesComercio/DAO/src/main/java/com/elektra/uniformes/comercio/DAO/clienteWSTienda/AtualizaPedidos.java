
package com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for AtualizaPedidos complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="AtualizaPedidos">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="KeyWs" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ModifPed" type="{http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo}ArrayOfActPedidos" minOccurs="0"/>
 *         &lt;element name="TipoNegocio" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="TipoSistema" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="TipoUsuario" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "AtualizaPedidos", propOrder = {
    "keyWs",
    "modifPed",
    "tipoNegocio",
    "tipoSistema",
    "tipoUsuario"
})
public class AtualizaPedidos {

    @XmlElementRef(name = "KeyWs", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<String> keyWs;
    @XmlElementRef(name = "ModifPed", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<ArrayOfActPedidos> modifPed;
    @XmlElement(name = "TipoNegocio")
    protected Integer tipoNegocio;
    @XmlElement(name = "TipoSistema")
    protected Integer tipoSistema;
    @XmlElement(name = "TipoUsuario")
    protected Integer tipoUsuario;

    /**
     * Gets the value of the keyWs property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getKeyWs() {
        return keyWs;
    }

    /**
     * Sets the value of the keyWs property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setKeyWs(JAXBElement<String> value) {
        this.keyWs = ((JAXBElement<String> ) value);
    }

    /**
     * Gets the value of the modifPed property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link ArrayOfActPedidos }{@code >}
     *     
     */
    public JAXBElement<ArrayOfActPedidos> getModifPed() {
        return modifPed;
    }

    /**
     * Sets the value of the modifPed property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link ArrayOfActPedidos }{@code >}
     *     
     */
    public void setModifPed(JAXBElement<ArrayOfActPedidos> value) {
        this.modifPed = ((JAXBElement<ArrayOfActPedidos> ) value);
    }

    /**
     * Gets the value of the tipoNegocio property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getTipoNegocio() {
        return tipoNegocio;
    }

    /**
     * Sets the value of the tipoNegocio property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setTipoNegocio(Integer value) {
        this.tipoNegocio = value;
    }

    /**
     * Gets the value of the tipoSistema property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getTipoSistema() {
        return tipoSistema;
    }

    /**
     * Sets the value of the tipoSistema property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setTipoSistema(Integer value) {
        this.tipoSistema = value;
    }

    /**
     * Gets the value of the tipoUsuario property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getTipoUsuario() {
        return tipoUsuario;
    }

    /**
     * Sets the value of the tipoUsuario property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setTipoUsuario(Integer value) {
        this.tipoUsuario = value;
    }

}
