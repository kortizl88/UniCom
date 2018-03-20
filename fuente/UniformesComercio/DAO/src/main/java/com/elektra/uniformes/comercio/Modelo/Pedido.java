/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.Modelo;

import java.util.ArrayList;

/**
 *
 * @author kortizl
 */
public class Pedido {
    private int numEmp;
    private String nombreEmp;
    private int folio;
    private int noTienda;
    private String nombreTienda;
    private String fecha;
    
    private ArrayList<DetallePedido> detallePedido;


    /**
     * @return the numEmp
     */
    public int getNumEmp() {
        return numEmp;
    }

    /**
     * @param numEmp the numEmp to set
     */
    public void setNumEmp(int numEmp) {
        this.numEmp = numEmp;
    }

    /**
     * @return the folio
     */
    public int getFolio() {
        return folio;
    }

    /**
     * @param folio the folio to set
     */
    public void setFolio(int folio) {
        this.folio = folio;
    }

    /**
     * @return the noTienda
     */
    public int getNoTienda() {
        return noTienda;
    }

    /**
     * @param noTienda the noTienda to set
     */
    public void setNoTienda(int noTienda) {
        this.noTienda = noTienda;
    }

    /**
     * @return the nombreTienda
     */
    public String getNombreTienda() {
        return nombreTienda;
    }

    /**
     * @param nombreTienda the nombreTienda to set
     */
    public void setNombreTienda(String nombreTienda) {
        this.nombreTienda = nombreTienda;
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
     * @return the detallePedido
     */
    public ArrayList<DetallePedido> getDetallePedido() {
        return detallePedido;
    }

    /**
     * @param detallePedido the detallePedido to set
     */
    public void setDetallePedido(ArrayList<DetallePedido> detallePedido) {
        this.detallePedido = detallePedido;
    }

    /**
     * @return the nombreEmp
     */
    public String getNombreEmp() {
        return nombreEmp;
    }

    /**
     * @param nombreEmp the nombreEmp to set
     */
    public void setNombreEmp(String nombreEmp) {
        this.nombreEmp = nombreEmp;
    }
}
