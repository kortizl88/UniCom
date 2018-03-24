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
public class ReporteDTO {
    @PropiedadMap(id=true, campo="FIIDEMPLEADO")
    private int empleado;
    @PropiedadMap(campo="FCNOMBRE")
    private String nombre;
    @PropiedadMap(campo="FIFOLIOSOLICITUD")
    private int solicitud;
    @PropiedadMap(campo="FCESTATUS")
    private String estatus;
    @PropiedadMap(campo="FCFUNCION")
    private String funcion;
    @PropiedadMap(campo="FDFECHACAPTURA")
    private String fecha;
    @PropiedadMap(campo="FIREMISION")
    private int remision;
    @PropiedadMap(lista=true, tipoComplejo = "com.elektra.uniformes.comercio.Modelo.PedidoReporteDTO")
    private ArrayList<PedidoReporteDTO> pedidos;

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
     * @return the estatus
     */
    public String getEstatus() {
        return estatus;
    }

    /**
     * @param estatus the estatus to set
     */
    public void setEstatus(String estatus) {
        this.estatus = estatus;
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
     * @return the remision
     */
    public int getRemision() {
        return remision;
    }

    /**
     * @param remision the remision to set
     */
    public void setRemision(int remision) {
        this.remision = remision;
    }

    /**
     * @return the pedidos
     */
    public ArrayList<PedidoReporteDTO> getPedidos() {
        return pedidos;
    }

    /**
     * @param pedidos the pedidos to set
     */
    public void setPedidos(ArrayList<PedidoReporteDTO> pedidos) {
        this.pedidos = pedidos;
    }
}
