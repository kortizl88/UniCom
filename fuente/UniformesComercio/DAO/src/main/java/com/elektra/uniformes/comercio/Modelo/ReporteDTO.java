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
    @PropiedadMap(id=true, campo="FIFOLIOSOLICITUD")
    private int solicitud;
    @PropiedadMap(id=true, campo="TIPOSOLICITUD")
    private String tipoSol;
    @PropiedadMap(campo="FIPAIS")
    private int pais;
    @PropiedadMap(campo="FICANAL")
    private int canal;
    @PropiedadMap(campo="FISUCURSAL")
    private int tienda;
    @PropiedadMap(campo="FCTIENDA")
    private String nombreTienda;
    @PropiedadMap(campo="FCESTATUS")
    private String estatus;
    @PropiedadMap(campo="FCFUNCION")
    private String funcion;
    @PropiedadMap(campo="FDFECHACAPTURA")
    private String fecha;
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

    /**
     * @return the pais
     */
    public int getPais() {
        return pais;
    }

    /**
     * @param pais the pais to set
     */
    public void setPais(int pais) {
        this.pais = pais;
    }

    /**
     * @return the canal
     */
    public int getCanal() {
        return canal;
    }

    /**
     * @param canal the canal to set
     */
    public void setCanal(int canal) {
        this.canal = canal;
    }

    /**
     * @return the tienda
     */
    public int getTienda() {
        return tienda;
    }

    /**
     * @param tienda the tienda to set
     */
    public void setTienda(int tienda) {
        this.tienda = tienda;
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
     * @return the tipoSol
     */
    public String getTipoSol() {
        return tipoSol;
    }

    /**
     * @param tipoSol the tipoSol to set
     */
    public void setTipoSol(String tipoSol) {
        this.tipoSol = tipoSol;
    }
}
