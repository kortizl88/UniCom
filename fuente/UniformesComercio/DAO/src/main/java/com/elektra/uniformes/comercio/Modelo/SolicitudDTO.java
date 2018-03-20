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
public class SolicitudDTO {
    private int numEmp;
    private int tipo;
    private int negocio;
    private int funcion;
    private int numEmpCaptura;
    private ArrayList<DetalleSolicitud> detalle;

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
     * @return the tipo
     */
    public int getTipo() {
        return tipo;
    }

    /**
     * @param tipo the tipo to set
     */
    public void setTipo(int tipo) {
        this.tipo = tipo;
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
     * @return the funcion
     */
    public int getFuncion() {
        return funcion;
    }

    /**
     * @param funcion the funcion to set
     */
    public void setFuncion(int funcion) {
        this.funcion = funcion;
    }

    /**
     * @return the numEmpCaptura
     */
    public int getNumEmpCaptura() {
        return numEmpCaptura;
    }

    /**
     * @param numEmpCaptura the numEmpCaptura to set
     */
    public void setNumEmpCaptura(int numEmpCaptura) {
        this.numEmpCaptura = numEmpCaptura;
    }

    /**
     * @return the detalle
     */
    public ArrayList<DetalleSolicitud> getDetalle() {
        return detalle;
    }

    /**
     * @param detalle the detalle to set
     */
    public void setDetalle(ArrayList<DetalleSolicitud> detalle) {
        this.detalle = detalle;
    }
}
