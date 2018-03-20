/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.Modelo;

import com.elektra.mapper.anotaciones.PropiedadMap;

public class InformacionPedidoDescuento {

    @PropiedadMap(campo="FCANO")
    private String cadenaAno;
    
    @PropiedadMap(campo="FISEMADESCUENTO")
    private int noSemanaDescuento;    
    
    @PropiedadMap(campo="FCFECHAPAGO")
    private String cadenaFechaPago;
    
    @PropiedadMap(campo="FCCOSTOPRENDA")
    private String cadenaCostoPrenda;
    
    @PropiedadMap(campo="FCSALDOPORPAGAR")
    private String cadenaSaldoPorPagar;

    @PropiedadMap(campo="FCPAGOSEMANAL")
    private String cadenaPagoSemanal;    

    public String getCadenaAno() {
        return cadenaAno;
    }

    public void setCadenaAno(String cadenaAno) {
        this.cadenaAno = cadenaAno;
    }

    public int getNoSemanaDescuento() {
        return noSemanaDescuento;
    }

    public void setNoSemanaDescuento(int noSemanaDescuento) {
        this.noSemanaDescuento = noSemanaDescuento;
    }

    public String getCadenaFechaPago() {
        return cadenaFechaPago;
    }

    public void setCadenaFechaPago(String cadenaFechaPago) {
        this.cadenaFechaPago = cadenaFechaPago;
    }

    public String getCadenaCostoPrenda() {
        return cadenaCostoPrenda;
    }

    public void setCadenaCostoPrenda(String cadenaCostoPrenda) {
        this.cadenaCostoPrenda = cadenaCostoPrenda;
    }

    public String getCadenaSaldoPorPagar() {
        return cadenaSaldoPorPagar;
    }

    public void setCadenaSaldoPorPagar(String cadenaSaldoPorPagar) {
        this.cadenaSaldoPorPagar = cadenaSaldoPorPagar;
    }

    public String getCadenaPagoSemanal() {
        return cadenaPagoSemanal;
    }

    public void setCadenaPagoSemanal(String cadenaPagoSemanal) {
        this.cadenaPagoSemanal = cadenaPagoSemanal;
    }


}
