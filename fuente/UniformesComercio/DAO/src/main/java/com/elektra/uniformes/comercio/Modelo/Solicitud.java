/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.Modelo;

import com.elektra.mapper.anotaciones.PropiedadMap;

public class Solicitud {
    
    @PropiedadMap(campo = "FIFOLIOSOLICITUD")
    private int nofolioSolicitud;
        
    @PropiedadMap(campo = "FCFECHACAPTURA")
    private String cadenafechaCaptura;
    
    @PropiedadMap(campo = "FISUCURSAL")
    private int noSucursal;
        
    @PropiedadMap(campo = "FCNOMBRE")
    private String cadenaNombreTienda;
    
    @PropiedadMap(campo = "FICANCELADO")
    private int cancelado;

    public int getNofolioSolicitud() {
        return nofolioSolicitud;
    }

    public void setNofolioSolicitud(int nofolioSolicitud) {
        this.nofolioSolicitud = nofolioSolicitud;
    }

    public String getCadenafechaCaptura() {
        return cadenafechaCaptura;
    }

    public void setCadenafechaCaptura(String cadenafechaCaptura) {
        this.cadenafechaCaptura = cadenafechaCaptura;
    }

    public int getNoSucursal() {
        return noSucursal;
    }

    public void setNoSucursal(int noSucursal) {
        this.noSucursal = noSucursal;
    }

    public String getCadenaNombreTienda() {
        return cadenaNombreTienda;
    }

    public void setCadenaNombreTienda(String cadenaNombreTienda) {
        this.cadenaNombreTienda = cadenaNombreTienda;
    }    

    /**
     * @return the cancelado
     */
    public int getCancelado() {
        return cancelado;
    }

    /**
     * @param cancelado the cancelado to set
     */
    public void setCancelado(int cancelado) {
        this.cancelado = cancelado;
    }
    
}
