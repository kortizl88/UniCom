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
public class Talla {
    @PropiedadMap(id=true, campo="FITALLA")
    private int idTalla;
    @PropiedadMap(campo="FCTALLA")
    private String talla;

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
     * @return the talla
     */
    public String getTalla() {
        return talla;
    }

    /**
     * @param talla the talla to set
     */
    public void setTalla(String talla) {
        this.talla = talla;
    }
}
