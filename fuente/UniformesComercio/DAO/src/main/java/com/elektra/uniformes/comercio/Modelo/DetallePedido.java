/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.Modelo;

/**
 *
 * @author kortizl
 */
public class DetallePedido {
    private int pedidoCD;
    private int sku;
    private String descripcionPrenda;
    private int cantidad;
    private String fechaCancelacion;
    private String remision;
    private int noRemision;
    private String estatus;

    /**
     * @return the pedidoCD
     */
    public int getPedidoCD() {
        return pedidoCD;
    }

    /**
     * @param pedidoCD the pedidoCD to set
     */
    public void setPedidoCD(int pedidoCD) {
        this.pedidoCD = pedidoCD;
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
     * @return the descripcionPrenda
     */
    public String getDescripcionPrenda() {
        return descripcionPrenda;
    }

    /**
     * @param descripcionPrenda the descripcionPrenda to set
     */
    public void setDescripcionPrenda(String descripcionPrenda) {
        this.descripcionPrenda = descripcionPrenda;
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
     * @return the fechaCancelacion
     */
    public String getFechaCancelacion() {
        return fechaCancelacion;
    }

    /**
     * @param fechaCancelacion the fechaCancelacion to set
     */
    public void setFechaCancelacion(String fechaCancelacion) {
        this.fechaCancelacion = fechaCancelacion;
    }

    /**
     * @return the remision
     */
    public String getRemision() {
        return remision;
    }

    /**
     * @param remision the remision to set
     */
    public void setRemision(String remision) {
        this.remision = remision;
    }

    /**
     * @return the noRemision
     */
    public int getNoRemision() {
        return noRemision;
    }

    /**
     * @param noRemision the noRemision to set
     */
    public void setNoRemision(int noRemision) {
        this.noRemision = noRemision;
    }

    /**
     * @return the estatus
     */
    public String getEstatus() {
        return estatus;
    }

    /**
     * @param estatus the estatus to set
     */
    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }
}
