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
public class Kit {
    @PropiedadMap(id=true, campo="FIKIT")
    private int idKit;
    @PropiedadMap(id=true, campo="FCKIT")
    private String nombreKit;
    @PropiedadMap(lista = true, tipoComplejo = "com.elektra.uniformes.comercio.Modelo.Prenda")
    private ArrayList<Prenda> prendas;

    /**
     * @return the idKit
     */
    public int getIdKit() {
        return idKit;
    }

    /**
     * @param idKit the idKit to set
     */
    public void setIdKit(int idKit) {
        this.idKit = idKit;
    }

    /**
     * @return the nombreKit
     */
    public String getNombreKit() {
        return nombreKit;
    }

    /**
     * @param nombreKit the nombreKit to set
     */
    public void setNombreKit(String nombreKit) {
        this.nombreKit = nombreKit;
    }

    /**
     * @return the prendas
     */
    public ArrayList<Prenda> getPrendas() {
        return prendas;
    }

    /**
     * @param prendas the prendas to set
     */
    public void setPrendas(ArrayList<Prenda> prendas) {
        this.prendas = prendas;
    }
}
