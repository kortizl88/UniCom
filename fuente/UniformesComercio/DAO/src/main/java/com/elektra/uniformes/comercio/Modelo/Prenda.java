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
public class Prenda {
    @PropiedadMap(id=true, campo="FIIDTIPOPRENDA")
    private int idTipoPrenda;
    @PropiedadMap(campo="FCTIPOPRENDA")
    private String descPrenda;
    @PropiedadMap(campo="FCIMAGEN")
    private String imagen;
    @PropiedadMap(campo="FNVALOR")
    private double precio;
    @PropiedadMap(campo="FIMINIMO")
    private int minimo;
    @PropiedadMap(campo="FIMAXIMO")
    private int maximo;
    @PropiedadMap(lista = true, tipoComplejo = "com.elektra.uniformes.comercio.Modelo.Talla")
    private ArrayList<Talla> tallas;

    /**
     * @return the idTipoPrenda
     */
    public int getIdTipoPrenda() {
        return idTipoPrenda;
    }

    /**
     * @param idTipoPrenda the idTipoPrenda to set
     */
    public void setIdTipoPrenda(int idTipoPrenda) {
        this.idTipoPrenda = idTipoPrenda;
    }

    /**
     * @return the descPrenda
     */
    public String getDescPrenda() {
        return descPrenda;
    }

    /**
     * @param descPrenda the descPrenda to set
     */
    public void setDescPrenda(String descPrenda) {
        this.descPrenda = descPrenda;
    }

    /**
     * @return the tallas
     */
    public ArrayList<Talla> getTallas() {
        return tallas;
    }

    /**
     * @param tallas the tallas to set
     */
    public void setTallas(ArrayList<Talla> tallas) {
        this.tallas = tallas;
    }

    /**
     * @return the imagen
     */
    public String getImagen() {
        return imagen;
    }

    /**
     * @param imagen the imagen to set
     */
    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    /**
     * @return the precio
     */
    public double getPrecio() {
        return precio;
    }

    /**
     * @param precio the precio to set
     */
    public void setPrecio(double precio) {
        this.precio = precio;
    }

    /**
     * @return the minimo
     */
    public int getMinimo() {
        return minimo;
    }

    /**
     * @param minimo the minimo to set
     */
    public void setMinimo(int minimo) {
        this.minimo = minimo;
    }

    /**
     * @return the maximo
     */
    public int getMaximo() {
        return maximo;
    }

    /**
     * @param maximo the maximo to set
     */
    public void setMaximo(int maximo) {
        this.maximo = maximo;
    }
}
