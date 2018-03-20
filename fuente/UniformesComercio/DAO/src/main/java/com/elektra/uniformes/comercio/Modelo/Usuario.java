/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.Modelo;

import com.elektra.mapper.anotaciones.PropiedadMap;

/**
 *
 * @author kortizl
 */
public class Usuario {
    @PropiedadMap(id=true, campo="FIEMPLEADO")
    private int empleado;
    @PropiedadMap(campo="FCNOMBRE")
    private String nombre;
    @PropiedadMap(campo="FCGENERO")
    private String genero;
    @PropiedadMap(campo="FIFUNCION")
    private int funcionSAP;
    @PropiedadMap(campo="FIIDNEGOCIO")
    private int negocio;
    @PropiedadMap(campo="FISOLICITUDPLANTILA")
    private int solicitudPlantilla;
    @PropiedadMap(campo="FISOLICITAENTIENDA")
    private int solicitaEnTienda;
    @PropiedadMap(campo="FIPOSICION")
    private int posicion;
    @PropiedadMap(campo="FCPOSICION")
    private String descPosicion;
    @PropiedadMap(campo="FDINGRESO")
    private String fechaIngreso;
    @PropiedadMap(campo="FCSITUACION")
    private String situacion;
    @PropiedadMap(campo="FIPAIS")
    private int idPais;
    @PropiedadMap(campo="FCPAIS")
    private String pais;
    @PropiedadMap(campo="FICANAL")
    private int canal;
    @PropiedadMap(campo="FICECO")
    private int ceco;
    @PropiedadMap(campo="FCCECO")
    private String descCeco;
    
    

    /**
     * @return the empleado
     */
    public int getEmpleado() {
        return empleado;
    }

    /**
     * @param empleado the empleado to set
     */
    public void setEmpleado(int empleado) {
        this.empleado = empleado;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * @return the genero
     */
    public String getGenero() {
        return genero;
    }

    /**
     * @param genero the genero to set
     */
    public void setGenero(String genero) {
        this.genero = genero;
    }

    /**
     * @return the posicion
     */
    public int getPosicion() {
        return posicion;
    }

    /**
     * @param posicion the posicion to set
     */
    public void setPosicion(int posicion) {
        this.posicion = posicion;
    }

    /**
     * @return the descPosicion
     */
    public String getDescPosicion() {
        return descPosicion;
    }

    /**
     * @param descPosicion the descPosicion to set
     */
    public void setDescPosicion(String descPosicion) {
        this.descPosicion = descPosicion;
    }

    /**
     * @return the situacion
     */
    public String getSituacion() {
        return situacion;
    }

    /**
     * @param situacion the situacion to set
     */
    public void setSituacion(String situacion) {
        this.situacion = situacion;
    }

    /**
     * @return the ceco
     */
    public int getCeco() {
        return ceco;
    }

    /**
     * @param ceco the ceco to set
     */
    public void setCeco(int ceco) {
        this.ceco = ceco;
    }

    /**
     * @return the descCeco
     */
    public String getDescCeco() {
        return descCeco;
    }

    /**
     * @param descCeco the descCeco to set
     */
    public void setDescCeco(String descCeco) {
        this.descCeco = descCeco;
    }

    /**
     * @return the pais
     */
    public String getPais() {
        return pais;
    }

    /**
     * @param pais the pais to set
     */
    public void setPais(String pais) {
        this.pais = pais;
    }

    /**
     * @return the fechaIngreso
     */
    public String getFechaIngreso() {
        return fechaIngreso;
    }

    /**
     * @param fechaIngreso the fechaIngreso to set
     */
    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    /**
     * @return the funcionSAP
     */
    public int getFuncionSAP() {
        return funcionSAP;
    }

    /**
     * @param funcionSAP the funcionSAP to set
     */
    public void setFuncionSAP(int funcionSAP) {
        this.funcionSAP = funcionSAP;
    }

    /**
     * @return the negocio
     */
    public int getNegocio() {
        return negocio;
    }

    /**
     * @param negocio the negocio to set
     */
    public void setNegocio(int negocio) {
        this.negocio = negocio;
    }

    /**
     * @return the idPais
     */
    public int getIdPais() {
        return idPais;
    }

    /**
     * @param idPais the idPais to set
     */
    public void setIdPais(int idPais) {
        this.idPais = idPais;
    }

    public int getCanal() {
        return canal;
    }

    public void setCanal(int canal) {
        this.canal = canal;
    }

    /**
     * @return the solicitaEnTienda
     */
    public int getSolicitaEnTienda() {
        return solicitaEnTienda;
    }

    /**
     * @param solicitaEnTienda the solicitaEnTienda to set
     */
    public void setSolicitaEnTienda(int solicitaEnTienda) {
        this.solicitaEnTienda = solicitaEnTienda;
    }

    /**
     * @return the solicitudPlantilla
     */
    public int getSolicitudPlantilla() {
        return solicitudPlantilla;
    }

    /**
     * @param solicitudPlantilla the solicitudPlantilla to set
     */
    public void setSolicitudPlantilla(int solicitudPlantilla) {
        this.solicitudPlantilla = solicitudPlantilla;
    }
}
