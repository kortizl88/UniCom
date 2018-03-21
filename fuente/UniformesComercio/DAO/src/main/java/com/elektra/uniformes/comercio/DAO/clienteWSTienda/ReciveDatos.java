
package com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ReciveDatos complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ReciveDatos">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="EmpNvo" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="Empleado" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="KeyWs" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="Negocio" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="NoEmpIngreso" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="NumTienda" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="Sku" type="{http://schemas.microsoft.com/2003/10/Serialization/Arrays}ArrayOfint" minOccurs="0"/>
 *         &lt;element name="TipoSistema" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="TipoUniforme" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
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
@XmlType(name = "ReciveDatos", propOrder = {
    "empNvo",
    "empleado",
    "keyWs",
    "negocio",
    "noEmpIngreso",
    "numTienda",
    "sku",
    "tipoSistema",
    "tipoUniforme",
    "tipoUsuario"
})
public class ReciveDatos {

    @XmlElement(name = "EmpNvo")
    protected Integer empNvo;
    @XmlElementRef(name = "Empleado", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<String> empleado;
    @XmlElementRef(name = "KeyWs", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<String> keyWs;
    @XmlElement(name = "Negocio")
    protected Integer negocio;
    @XmlElementRef(name = "NoEmpIngreso", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<String> noEmpIngreso;
    @XmlElementRef(name = "NumTienda", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<String> numTienda;
    @XmlElementRef(name = "Sku", namespace = "http://schemas.datacontract.org/2004/07/Elektra.Servicios.Datos.AdmonUniformes.Modelo", type = JAXBElement.class)
    protected JAXBElement<ArrayOfint> sku;
    @XmlElement(name = "TipoSistema")
    protected Integer tipoSistema;
    @XmlElement(name = "TipoUniforme")
    protected Integer tipoUniforme;
    @XmlElement(name = "TipoUsuario")
    protected Integer tipoUsuario;

    /**
     * Gets the value of the empNvo property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getEmpNvo() {
        return empNvo;
    }

    /**
     * Sets the value of the empNvo property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setEmpNvo(Integer value) {
        this.empNvo = value;
    }

    /**
     * Gets the value of the empleado property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getEmpleado() {
        return empleado;
    }

    /**
     * Sets the value of the empleado property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setEmpleado(JAXBElement<String> value) {
        this.empleado = ((JAXBElement<String> ) value);
    }

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
     * Gets the value of the negocio property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getNegocio() {
        return negocio;
    }

    /**
     * Sets the value of the negocio property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setNegocio(Integer value) {
        this.negocio = value;
    }

    /**
     * Gets the value of the noEmpIngreso property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getNoEmpIngreso() {
        return noEmpIngreso;
    }

    /**
     * Sets the value of the noEmpIngreso property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setNoEmpIngreso(JAXBElement<String> value) {
        this.noEmpIngreso = ((JAXBElement<String> ) value);
    }

    /**
     * Gets the value of the numTienda property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getNumTienda() {
        return numTienda;
    }

    /**
     * Sets the value of the numTienda property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setNumTienda(JAXBElement<String> value) {
        this.numTienda = ((JAXBElement<String> ) value);
    }

    /**
     * Gets the value of the sku property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link ArrayOfint }{@code >}
     *     
     */
    public JAXBElement<ArrayOfint> getSku() {
        return sku;
    }

    /**
     * Sets the value of the sku property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link ArrayOfint }{@code >}
     *     
     */
    public void setSku(JAXBElement<ArrayOfint> value) {
        this.sku = ((JAXBElement<ArrayOfint> ) value);
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
     * Gets the value of the tipoUniforme property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getTipoUniforme() {
        return tipoUniforme;
    }

    /**
     * Sets the value of the tipoUniforme property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setTipoUniforme(Integer value) {
        this.tipoUniforme = value;
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
