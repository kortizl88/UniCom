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
public class PedidoReporteDTO {

    @PropiedadMap(id = true, campo = "FIPEDIDO")
    private int pedido;
    @PropiedadMap(campo = "FISKU")
    private int sku;
    @PropiedadMap(campo = "FCPRENDA")
    private String descripcion;
    @PropiedadMap(campo = "FITALLA")
    private int talla;
    @PropiedadMap(campo = "FCTALLA")
    private String descTalla;
    @PropiedadMap(campo = "FICANTIDAD")
    private int cantidad;
    @PropiedadMap(campo = "FCESTATUS")
    private String estatusPedido;
    @PropiedadMap(campo = "FIREMISION")
    private int remision;
    @PropiedadMap(campo = "FDFECHAACT")
    private String fechaAct;
    @PropiedadMap(campo = "FICEDIS")
    private int cedis;
    @PropiedadMap(campo = "FCCEDIS")
    private String nombreCedis;

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
     * @return the sku
     */
    public int getSku() {
        return sku;
    }

    /**
     * @param sku the sku to set
     */
    public void setSku(int sku) {
        this.sku = sku;
    }

    /**
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the cantidad
     */
    public int getCantidad() {
        return cantidad;
    }

    /**
     * @param cantidad the cantidad to set
     */
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    /**
     * @return the talla
     */
    public int getTalla() {
        return talla;
    }

    /**
     * @param talla the talla to set
     */
    public void setTalla(int talla) {
        this.talla = talla;
    }

    /**
     * @return the descTalla
     */
    public String getDescTalla() {
        return descTalla;
    }

    /**
     * @param descTalla the descTalla to set
     */
    public void setDescTalla(String descTalla) {
        this.descTalla = descTalla;
    }

    /**
     * @return the estatusPedido
     */
    public String getEstatusPedido() {
        return estatusPedido;
    }

    /**
     * @param estatusPedido the estatusPedido to set
     */
    public void setEstatusPedido(String estatusPedido) {
        this.estatusPedido = estatusPedido;
    }

    /**
     * @return the remision
     */
    public int getRemision() {
        return remision;
    }

    /**
     * @param remision the remision to set
     */
    public void setRemision(int remision) {
        this.remision = remision;
    }

    /**
     * @return the fechaAct
     */
    public String getFechaAct() {
        return fechaAct;
    }

    /**
     * @param fechaAct the fechaAct to set
     */
    public void setFechaAct(String fechaAct) {
        this.fechaAct = fechaAct;
    }

    /**
     * @return the cedis
     */
    public int getCedis() {
        return cedis;
    }

    /**
     * @param cedis the cedis to set
     */
    public void setCedis(int cedis) {
        this.cedis = cedis;
    }

    /**
     * @return the nombreCedis
     */
    public String getNombreCedis() {
        return nombreCedis;
    }

    /**
     * @param nombreCedis the nombreCedis to set
     */
    public void setNombreCedis(String nombreCedis) {
        this.nombreCedis = nombreCedis;
    }
}
