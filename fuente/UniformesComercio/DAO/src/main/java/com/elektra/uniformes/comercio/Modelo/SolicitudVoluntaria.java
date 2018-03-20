/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.Modelo;

import com.elektra.mapper.anotaciones.PropiedadMap;

public class SolicitudVoluntaria {
    
    @PropiedadMap(campo = "FIFOLIOSOLICITUD")
    private int nofolioSolicitud;
        
    @PropiedadMap(campo = "FCFECHACAPTURA")
    private String cadenaFechaCaptura;

    public int getNofolioSolicitud() {
        return nofolioSolicitud;
    }

    public void setNofolioSolicitud(int nofolioSolicitud) {
        this.nofolioSolicitud = nofolioSolicitud;
    }

    public String getCadenaFechaCaptura() {
        return cadenaFechaCaptura;
    }

    public void setCadenaFechaCaptura(String cadenaFechaCaptura) {
        this.cadenaFechaCaptura = cadenaFechaCaptura;
    }

}
