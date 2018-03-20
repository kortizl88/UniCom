/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.Modelo;

import com.elektra.mapper.anotaciones.PropiedadMap;

/**
 * 
 */
public class Tracking {
    
    @PropiedadMap(campo = "FINUMPEDIDO")
    private int noPedido;
    
    @PropiedadMap(campo = "FCSKU")
    private String cadenaSKU;
    
    @PropiedadMap(campo = "FCDESCRIPCION")
    private String cadenaDescripcionPrenda;
    
    @PropiedadMap(campo = "FIREMISION")
    private int noRemision;
    
    @PropiedadMap(campo = "FICANTIDAD")
    private int noCantidad;
    
    @PropiedadMap(campo = "FCIDESTATUSNVO")
    private String cadenaEstatusNuevo;
    
    @PropiedadMap(campo = "FIIDDETALLE")
    private int noSolicitudDetalle;
    
    @PropiedadMap(campo = "FCFECHAEVENTO")
    private String cadenaFechaEvento;

    public int getNoPedido() {
        return noPedido;
    }

    public void setNoPedido(int noPedido) {
        this.noPedido = noPedido;
    }

    public String getCadenaSKU() {
        return cadenaSKU;
    }

    public void setCadenaSKU(String cadenaSKU) {
        this.cadenaSKU = cadenaSKU;
    }

    public String getCadenaDescripcionPrenda() {
        return cadenaDescripcionPrenda;
    }

    public void setCadenaDescripcionPrenda(String cadenaDescripcionPrenda) {
        this.cadenaDescripcionPrenda = cadenaDescripcionPrenda;
    }

    public int getNoRemision() {
        return noRemision;
    }

    public void setNoRemision(int noRemision) {
        this.noRemision = noRemision;
    }

    public int getNoCantidad() {
        return noCantidad;
    }

    public void setNoCantidad(int noCantidad) {
        this.noCantidad = noCantidad;
    }

    public String getCadenaEstatusNuevo() {
        return cadenaEstatusNuevo;
    }

    public void setCadenaEstatusNuevo(String cadenaEstatusNuevo) {
        this.cadenaEstatusNuevo = cadenaEstatusNuevo;
    }

    public int getNoSolicitudDetalle() {
        return noSolicitudDetalle;
    }

    public void setNoSolicitudDetalle(int noSolicitudDetalle) {
        this.noSolicitudDetalle = noSolicitudDetalle;
    }

    public String getCadenaFechaEvento() {
        return cadenaFechaEvento;
    }

    public void setCadenaFechaEvento(String cadenaFechaEvento) {
        this.cadenaFechaEvento = cadenaFechaEvento;
    }


}
