/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.Modelo;

import com.elektra.mapper.anotaciones.PropiedadMap;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;

/**
 *
 * @author kortizl
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class CentroDistribucion {
    @PropiedadMap(id = true, campo = "FIPAIS")
    private int pais;
    @PropiedadMap(id = true, campo = "FICD")
    private int cedis;
    @PropiedadMap(campo = "FCCEDIS")
    private String descCedis;

    /**
     * @return the cedis
     */
    public int getCedis() {
        return cedis;
    }

    /**
     * @param cedis the cedis to set
     */
    public void setCedis(int cedis) {
        this.cedis = cedis;
    }

    /**
     * @return the descCedis
     */
    public String getDescCedis() {
        return descCedis;
    }

    /**
     * @param descCedis the descCedis to set
     */
    public void setDescCedis(String descCedis) {
        this.descCedis = descCedis;
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
}
