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
public class Menu {
    @PropiedadMap(id=true, campo = "FIIDMENU")
    private int idMenu;
    @PropiedadMap(campo = "FCTITULO")
    private String titulo;
    @PropiedadMap(campo = "FCDESCMENU")
    private String descMenu;
    @PropiedadMap(campo = "FCRUTAENLACE")
    private String ruta;

    /**
     * @return the idMenu
     */
    public int getIdMenu() {
        return idMenu;
    }

    /**
     * @param idMenu the idMenu to set
     */
    public void setIdMenu(int idMenu) {
        this.idMenu = idMenu;
    }

    /**
     * @return the descMenu
     */
    public String getDescMenu() {
        return descMenu;
    }

    /**
     * @param descMenu the descMenu to set
     */
    public void setDescMenu(String descMenu) {
        this.descMenu = descMenu;
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
     * @return the ruta
     */
    public String getRuta() {
        return ruta;
    }

    /**
     * @param ruta the ruta to set
     */
    public void setRuta(String ruta) {
        this.ruta = ruta;
    }
}
