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
public class DetalleEntrega {
    @PropiedadMap(id=true, campo="FIFOLIOSOLICITUD")
    private int solicitud;
    @PropiedadMap(id=true, campo="FIIDDETALLE")
    private int noIdDetalle;
    @PropiedadMap(id=true, campo="FIPAIS")
    private int noPais;
    @PropiedadMap(id=true, campo="FICANAL")
    private int noCanal;
    @PropiedadMap(id=true, campo="FIIDSUCURSAL")
    private int noSucursal;      
    @PropiedadMap(id=true, campo="FIPEDIDO")
    private int pedido;
    @PropiedadMap(id=true, campo="FISKU")
    private int sku;
    @PropiedadMap(id=true, campo="PRENDA")
    private String prenda;
    @PropiedadMap(campo="FICANTIDAD")
    private int cantidad;
    @PropiedadMap(campo="FIREMISION")
    private int remision;

    /**
     * @return the solicitud
     */
    public int getSolicitud() {
        return solicitud;
    }

    /**
     * @param solicitud the solicitud to set
     */
    public void setSolicitud(int solicitud) {
        this.solicitud = solicitud;
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
     * @return the prenda
     */
    public String getPrenda() {
        return prenda;
    }

    /**
     * @param prenda the prenda to set
     */
    public void setPrenda(String prenda) {
        this.prenda = prenda;
    }

    public int getNoIdDetalle() {
        return noIdDetalle;
    }

    public void setNoIdDetalle(int noIdDetalle) {
        this.noIdDetalle = noIdDetalle;
    }

    public int getNoPais() {
        return noPais;
    }

    public void setNoPais(int noPais) {
        this.noPais = noPais;
    }

    public int getNoCanal() {
        return noCanal;
    }

    public void setNoCanal(int noCanal) {
        this.noCanal = noCanal;
    }

    public int getNoSucursal() {
        return noSucursal;
    }

    public void setNoSucursal(int noSucursal) {
        this.noSucursal = noSucursal;
    }
    
    
}
