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
public class Negocio {
    @PropiedadMap(id=true, campo = "FIIDNEGOCIO")
    private int idNegocio;
    @PropiedadMap(campo = "FCNEGOCIO")
    private String negocio;

    /**
     * @return the idNegocio
     */
    public int getIdNegocio() {
        return idNegocio;
    }

    /**
     * @param idNegocio the idNegocio to set
     */
    public void setIdNegocio(int idNegocio) {
        this.idNegocio = idNegocio;
    }

    /**
     * @return the negocio
     */
    public String getNegocio() {
        return negocio;
    }

    /**
     * @param negocio the negocio to set
     */
    public void setNegocio(String negocio) {
        this.negocio = negocio;
    }
}
