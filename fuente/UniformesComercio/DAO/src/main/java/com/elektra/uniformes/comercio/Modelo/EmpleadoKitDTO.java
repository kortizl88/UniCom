/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.Modelo;

import com.elektra.mapper.anotaciones.PropiedadMap;
import java.util.ArrayList;

/**
 *
 * @author kortizl
 */
public class EmpleadoKitDTO {
    @PropiedadMap(id=true, campo="FIEMPLEADO")
    private int empleado;
    @PropiedadMap(campo="FCNOMBRE")
    private String nombre;
    @PropiedadMap(campo="FIFUNCION")
    private int funcion;
    @PropiedadMap(campo="FCGENERO")
    private String genero;
    @PropiedadMap(tipoComplejo = "com.elektra.uniformes.comercio.Modelo.Kit")
    private Kit kit;

    /**
     * @return the empleado
     */
    public int getEmpleado() {
        return empleado;
    }

    /**
     * @param empleado the empleado to set
     */
    public void setEmpleado(int empleado) {
        this.empleado = empleado;
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
     * @return the genero
     */
    public String getGenero() {
        return genero;
    }

    /**
     * @param genero the genero to set
     */
    public void setGenero(String genero) {
        this.genero = genero;
    }

    /**
     * @return the kit
     */
    public Kit getKit() {
        return kit;
    }

    /**
     * @param kit the kit to set
     */
    public void setKit(Kit kit) {
        this.kit = kit;
    }
}
