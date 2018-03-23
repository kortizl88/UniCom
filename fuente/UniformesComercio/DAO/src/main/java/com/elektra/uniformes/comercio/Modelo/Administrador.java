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
public class Administrador {
    @PropiedadMap(id=true, campo = "FINUMEMPLEADO")
    private int numeroEmpledo;
    @PropiedadMap(campo = "FCNOMBRE")
    private String nombre;
    @PropiedadMap(campo = "FCAREA")
    private String area;

    /**
     * @return the numeroEmpledo
     */
    public int getNumeroEmpledo() {
        return numeroEmpledo;
    }

    /**
     * @param numeroEmpledo the numeroEmpledo to set
     */
    public void setNumeroEmpledo(int numeroEmpledo) {
        this.numeroEmpledo = numeroEmpledo;
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
     * @return the area
     */
    public String getArea() {
        return area;
    }

    /**
     * @param area the area to set
     */
    public void setArea(String area) {
        this.area = area;
    }
}
