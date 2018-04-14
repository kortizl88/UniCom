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
public class Tienda {
    @PropiedadMap(id=true, campo="FIPAIS")
    private int pais;
    @PropiedadMap(id=true, campo="FICANAL")
    private int canal;
    @PropiedadMap(id=true, campo="FISUCURSAL")
    private int sucursal;
    @PropiedadMap(campo="FICECO")
    private int centroCostos;
    @PropiedadMap(campo="FCNOMBRE")
    private String nombreTienda;
    @PropiedadMap(campo="FISOLICITAENTIENDA")
    private int tiendaReceptora;
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

    public int getCanal() {
        return canal;
    }

    public void setCanal(int canal) {
        this.canal = canal;
    }

    /**
     * @return the sucursal
     */
    public int getSucursal() {
        return sucursal;
    }

    /**
     * @param sucursal the sucursal to set
     */
    public void setSucursal(int sucursal) {
        this.sucursal = sucursal;
    }

    /**
     * @return the tiendaReceptora
     */
    public int getTiendaReceptora() {
        return tiendaReceptora;
    }

    /**
     * @param tiendaReceptora the tiendaReceptora to set
     */
    public void setTiendaReceptora(int tiendaReceptora) {
        this.tiendaReceptora = tiendaReceptora;
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
     * @return the centroCostos
     */
    public int getCentroCostos() {
        return centroCostos;
    }

    /**
     * @param centroCostos the centroCostos to set
     */
    public void setCentroCostos(int centroCostos) {
        this.centroCostos = centroCostos;
    }
}
