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
public class RespuestaSolicitudDTO {
    @PropiedadMap(id=true, campo="FIFOLIOSOLICITUD")
    private int solicitud;
    @PropiedadMap(campo="FIEMPLEADO")
    private int empleado;
    @PropiedadMap(campo="FCNOMBRE")
    private String nombre;

    /**
     * @return the solicitud
     */
    public int getSolicitud() {
        return solicitud;
    }

    /**
     * @param solicitud the solicitud to set
     */
    public void setSolicitud(int solicitud) {
        this.solicitud = solicitud;
    }

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
}
