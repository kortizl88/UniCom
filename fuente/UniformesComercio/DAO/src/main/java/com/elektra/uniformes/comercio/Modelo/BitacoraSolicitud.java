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
public class BitacoraSolicitud {
    @PropiedadMap(id=true, campo="FIFOLIOSOLICITUD")
    private int folioSolicitud;
    @PropiedadMap(id=true, campo="FIIDDETALLE")
    private int detalle;
    @PropiedadMap(campo="FIPAIS")
    private int pais;
    @PropiedadMap(campo="FICANAL")
    private int canal;
    @PropiedadMap(campo="FISUCURSAL")
    private int tienda;
    @PropiedadMap(campo="FIPEDIDO")
    private int pedido;
    @PropiedadMap(campo="FCDATOSPROCESO")
    private String datosProc;
    @PropiedadMap(campo="FCCOMENTARIOS")
    private String comentarios;
    @PropiedadMap(campo="EST_ANT")
    private String estatusAnt;
    @PropiedadMap(campo="EST_NUEVO")
    private String estatusNvo;
    @PropiedadMap(campo="FDFECHA")
    private String fecha;
    @PropiedadMap(campo="FIFOLIOREMISION")
    private int folioRemision;
    @PropiedadMap(campo="FINOTACARGO")
    private int notaCargo;
    @PropiedadMap(campo="FCOBSERVACIONNC")
    private String observacionesNC;
    @PropiedadMap(campo="FCOBSERVACIONNE")
    private String observacionesNE;
    
    /**
     * @return the folioSolicitud
     */
    public int getFolioSolicitud() {
        return folioSolicitud;
    }

    /**
     * @param folioSolicitud the folioSolicitud to set
     */
    public void setFolioSolicitud(int folioSolicitud) {
        this.folioSolicitud = folioSolicitud;
    }

    /**
     * @return the detalle
     */
    public int getDetalle() {
        return detalle;
    }

    /**
     * @param detalle the detalle to set
     */
    public void setDetalle(int detalle) {
        this.detalle = detalle;
    }

    /**
     * @return the pais
     */
    public int getPais() {
        return pais;
    }

    /**
     * @param pais the pais to set
     */
    public void setPais(int pais) {
        this.pais = pais;
    }

    /**
     * @return the canal
     */
    public int getCanal() {
        return canal;
    }

    /**
     * @param canal the canal to set
     */
    public void setCanal(int canal) {
        this.canal = canal;
    }

    /**
     * @return the tienda
     */
    public int getTienda() {
        return tienda;
    }

    /**
     * @param tienda the tienda to set
     */
    public void setTienda(int tienda) {
        this.tienda = tienda;
    }

    /**
     * @return the pedido
     */
    public int getPedido() {
        return pedido;
    }

    /**
     * @param pedido the pedido to set
     */
    public void setPedido(int pedido) {
        this.pedido = pedido;
    }

    /**
     * @return the datosProc
     */
    public String getDatosProc() {
        return datosProc;
    }

    /**
     * @param datosProc the datosProc to set
     */
    public void setDatosProc(String datosProc) {
        this.datosProc = datosProc;
    }

    /**
     * @return the comentarios
     */
    public String getComentarios() {
        return comentarios;
    }

    /**
     * @param comentarios the comentarios to set
     */
    public void setComentarios(String comentarios) {
        this.comentarios = comentarios;
    }

    /**
     * @return the estatusAnt
     */
    public String getEstatusAnt() {
        return estatusAnt;
    }

    /**
     * @param estatusAnt the estatusAnt to set
     */
    public void setEstatusAnt(String estatusAnt) {
        this.estatusAnt = estatusAnt;
    }

    /**
     * @return the estatusNvo
     */
    public String getEstatusNvo() {
        return estatusNvo;
    }

    /**
     * @param estatusNvo the estatusNvo to set
     */
    public void setEstatusNvo(String estatusNvo) {
        this.estatusNvo = estatusNvo;
    }

    /**
     * @return the fecha
     */
    public String getFecha() {
        return fecha;
    }

    /**
     * @param fecha the fecha to set
     */
    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    /**
     * @return the folioRemision
     */
    public int getFolioRemision() {
        return folioRemision;
    }

    /**
     * @param folioRemision the folioRemision to set
     */
    public void setFolioRemision(int folioRemision) {
        this.folioRemision = folioRemision;
    }

    /**
     * @return the notaCargo
     */
    public int getNotaCargo() {
        return notaCargo;
    }

    /**
     * @param notaCargo the notaCargo to set
     */
    public void setNotaCargo(int notaCargo) {
        this.notaCargo = notaCargo;
    }

    /**
     * @return the observacionesNC
     */
    public String getObservacionesNC() {
        return observacionesNC;
    }

    /**
     * @param observacionesNC the observacionesNC to set
     */
    public void setObservacionesNC(String observacionesNC) {
        this.observacionesNC = observacionesNC;
    }

    /**
     * @return the observacionesNE
     */
    public String getObservacionesNE() {
        return observacionesNE;
    }

    /**
     * @param observacionesNE the observacionesNE to set
     */
    public void setObservacionesNE(String observacionesNE) {
        this.observacionesNE = observacionesNE;
    }
           
}
