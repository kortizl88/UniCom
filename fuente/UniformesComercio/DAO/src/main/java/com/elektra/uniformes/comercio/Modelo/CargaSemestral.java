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
public class CargaSemestral {
    @PropiedadMap(id=true, campo = "FIIDCARGA")
    private int idCarga;
    @PropiedadMap(campo = "FCDESCRIPCION")
    private String titulo;
    @PropiedadMap(campo = "FDFECHAINICIAL")
    private String fechaInicio;
    @PropiedadMap(campo = "FDFECHAFINAL")
    private String fechaFin;
    @PropiedadMap(campo = "FIESTATUS")
    private int estatus;
    @PropiedadMap(campo = "FIGENERARPEDIDO")
    private int generarPedidos;
    @PropiedadMap(campo = "FITOTALSOLICITUDES")
    private int totalSolicitudes;
    @PropiedadMap(lista = true, tipoComplejo = "com.elektra.uniformes.comercio.Modelo.Negocio")
    private ArrayList<Negocio> negocios;
    @PropiedadMap(lista = true, tipoComplejo = "com.elektra.uniformes.comercio.Modelo.CentroDistribucion")
    private ArrayList<CentroDistribucion> cedis;

    /**
     * @return the idCarga
     */
    public int getIdCarga() {
        return idCarga;
    }

    /**
     * @param idCarga the idCarga to set
     */
    public void setIdCarga(int idCarga) {
        this.idCarga = idCarga;
    }

    /**
     * @return the titulo
     */
    public String getTitulo() {
        return titulo;
    }

    /**
     * @param titulo the titulo to set
     */
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    /**
     * @return the fechaInicio
     */
    public String getFechaInicio() {
        return fechaInicio;
    }

    /**
     * @param fechaInicio the fechaInicio to set
     */
    public void setFechaInicio(String fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    /**
     * @return the fechaFin
     */
    public String getFechaFin() {
        return fechaFin;
    }

    /**
     * @param fechaFin the fechaFin to set
     */
    public void setFechaFin(String fechaFin) {
        this.fechaFin = fechaFin;
    }

    /**
     * @return the estatus
     */
    public int getEstatus() {
        return estatus;
    }

    /**
     * @param estatus the estatus to set
     */
    public void setEstatus(int estatus) {
        this.estatus = estatus;
    }

    /**
     * @return the generarPedidos
     */
    public int getGenerarPedidos() {
        return generarPedidos;
    }

    /**
     * @param generarPedidos the generarPedidos to set
     */
    public void setGenerarPedidos(int generarPedidos) {
        this.generarPedidos = generarPedidos;
    }

    /**
     * @return the negocios
     */
    public ArrayList<Negocio> getNegocios() {
        return negocios;
    }

    /**
     * @param negocios the negocios to set
     */
    public void setNegocios(ArrayList<Negocio> negocios) {
        this.negocios = negocios;
    }

    /**
     * @return the totalSolicitudes
     */
    public int getTotalSolicitudes() {
        return totalSolicitudes;
    }

    /**
     * @param totalSolicitudes the totalSolicitudes to set
     */
    public void setTotalSolicitudes(int totalSolicitudes) {
        this.totalSolicitudes = totalSolicitudes;
    }

    /**
     * @return the cedis
     */
    public ArrayList<CentroDistribucion> getCedis() {
        return cedis;
    }

    /**
     * @param cedis the cedis to set
     */
    public void setCedis(ArrayList<CentroDistribucion> cedis) {
        this.cedis = cedis;
    }
}
