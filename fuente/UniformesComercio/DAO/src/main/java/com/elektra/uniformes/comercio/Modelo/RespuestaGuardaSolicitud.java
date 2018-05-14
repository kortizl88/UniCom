/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.Modelo;

import java.util.ArrayList;

/**
 *
 * @author kristian
 */
public class RespuestaGuardaSolicitud {
    private String fechaCancela;
    private ArrayList<RespuestaSolicitudDTO> solicitudes;

    /**
     * @return the fechaCancela
     */
    public String getFechaCancela() {
        return fechaCancela;
    }

    /**
     * @param fechaCancela the fechaCancela to set
     */
    public void setFechaCancela(String fechaCancela) {
        this.fechaCancela = fechaCancela;
    }

    /**
     * @return the solicitudes
     */
    public ArrayList<RespuestaSolicitudDTO> getSolicitudes() {
        return solicitudes;
    }

    /**
     * @param solicitudes the solicitudes to set
     */
    public void setSolicitudes(ArrayList<RespuestaSolicitudDTO> solicitudes) {
        this.solicitudes = solicitudes;
    }
}
