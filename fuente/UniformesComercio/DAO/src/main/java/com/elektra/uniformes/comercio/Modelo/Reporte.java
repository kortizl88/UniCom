/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.Modelo;

/**
 *
 * @author kortizl
 */
public class Reporte {
    private int numEmpleado;
    private String nombre;
    private String folio;
    private String estatusGral;
    private String funcion;
    private String fecha;
    private String fechaPrimerRemision;
    private String fechaUltimaRemision;

    /**
     * @return the numEmpleado
     */
    public int getNumEmpleado() {
        return numEmpleado;
    }

    /**
     * @param numEmpleado the numEmpleado to set
     */
    public void setNumEmpleado(int numEmpleado) {
        this.numEmpleado = numEmpleado;
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
     * @return the folio
     */
    public String getFolio() {
        return folio;
    }

    /**
     * @param folio the folio to set
     */
    public void setFolio(String folio) {
        this.folio = folio;
    }

    /**
     * @return the estatusGral
     */
    public String getEstatusGral() {
        return estatusGral;
    }

    /**
     * @param estatusGral the estatusGral to set
     */
    public void setEstatusGral(String estatusGral) {
        this.estatusGral = estatusGral;
    }

    /**
     * @return the funcion
     */
    public String getFuncion() {
        return funcion;
    }

    /**
     * @param funcion the funcion to set
     */
    public void setFuncion(String funcion) {
        this.funcion = funcion;
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
     * @return the fechaPrimerRemision
     */
    public String getFechaPrimerRemision() {
        return fechaPrimerRemision;
    }

    /**
     * @param fechaPrimerRemision the fechaPrimerRemision to set
     */
    public void setFechaPrimerRemision(String fechaPrimerRemision) {
        this.fechaPrimerRemision = fechaPrimerRemision;
    }

    /**
     * @return the fechaUltimaRemision
     */
    public String getFechaUltimaRemision() {
        return fechaUltimaRemision;
    }

    /**
     * @param fechaUltimaRemision the fechaUltimaRemision to set
     */
    public void setFechaUltimaRemision(String fechaUltimaRemision) {
        this.fechaUltimaRemision = fechaUltimaRemision;
    }
}
