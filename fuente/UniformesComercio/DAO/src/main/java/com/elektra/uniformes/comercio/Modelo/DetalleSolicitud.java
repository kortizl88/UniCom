/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.Modelo;

/**
 *
 * @author kortizl
 */
public class DetalleSolicitud {
    private int pais;
    private String canal;
    private int sucursal;
    private int idTipoPrenda;
    private int idTalla;
    private int cantidad;
    private double precioUnitario;

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
    public String getCanal() {
        return canal;
    }

    /**
     * @param canal the canal to set
     */
    public void setCanal(String canal) {
        this.canal = canal;
    }

    /**
     * @return the sucursal
     */
    public int getSucursal() {
        return sucursal;
    }

    /**
     * @param sucursal the sucursal to set
     */
    public void setSucursal(int sucursal) {
        this.sucursal = sucursal;
    }

    /**
     * @return the idTipoPrenda
     */
    public int getIdTipoPrenda() {
        return idTipoPrenda;
    }

    /**
     * @param idTipoPrenda the idTipoPrenda to set
     */
    public void setIdTipoPrenda(int idTipoPrenda) {
        this.idTipoPrenda = idTipoPrenda;
    }

    /**
     * @return the idTalla
     */
    public int getIdTalla() {
        return idTalla;
    }

    /**
     * @param idTalla the idTalla to set
     */
    public void setIdTalla(int idTalla) {
        this.idTalla = idTalla;
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
     * @return the precioUnitario
     */
    public double getPrecioUnitario() {
        return precioUnitario;
    }

    /**
     * @param precioUnitario the precioUnitario to set
     */
    public void setPrecioUnitario(double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }
}
