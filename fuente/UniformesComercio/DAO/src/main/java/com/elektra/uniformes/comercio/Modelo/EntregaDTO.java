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
public class EntregaDTO {
    
    @PropiedadMap(id=true, campo="FIEMPLEADO")
    private int empleado;
    @PropiedadMap(campo="FCNOMBRE")
    private String nombre;
    @PropiedadMap(campo="FCPOSICION")
    private String posicion;
    @PropiedadMap(campo="FICECO")
    private int noTienda;
    @PropiedadMap(campo="FCCECO")
    private String tienda;
    @PropiedadMap(campo="NEGOCIO")
    private String negocio;
    @PropiedadMap(lista=true, tipoComplejo = "com.elektra.uniformes.comercio.Modelo.DetalleEntrega")
    private ArrayList<DetalleEntrega> pedidos;

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
     * @return the posicion
     */
    public String getPosicion() {
        return posicion;
    }

    /**
     * @param posicion the posicion to set
     */
    public void setPosicion(String posicion) {
        this.posicion = posicion;
    }

    /**
     * @return the noTienda
     */
    public int getNoTienda() {
        return noTienda;
    }

    /**
     * @param noTienda the noTienda to set
     */
    public void setNoTienda(int noTienda) {
        this.noTienda = noTienda;
    }

    /**
     * @return the tienda
     */
    public String getTienda() {
        return tienda;
    }

    /**
     * @param tienda the tienda to set
     */
    public void setTienda(String tienda) {
        this.tienda = tienda;
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

    /**
     * @return the pedidos
     */
    public ArrayList<DetalleEntrega> getPedidos() {
        return pedidos;
    }

    /**
     * @param pedidos the pedidos to set
     */
    public void setPedidos(ArrayList<DetalleEntrega> pedidos) {
        this.pedidos = pedidos;
    }
    
    
}
