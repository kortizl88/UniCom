/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.Modelo;

import com.elektra.mapper.anotaciones.PropiedadMap;

/**
 * 
 */
public class PedidoDescuento {
    
    @PropiedadMap(campo="FIPEDIDO")
    private int noPedido;
    
    @PropiedadMap(campo="FCSKU")
    private String cadenaSku;
        
    @PropiedadMap(campo="FCDESCRIPCION")
    private String cadenaDescripcion;
    
    @PropiedadMap(campo="FIIDTIPOPRENDA")
    private int noTipoPrenda;   
    
    @PropiedadMap(campo="FCPAGADO")
    private String cadenaPagado;
    
    @PropiedadMap(campo="FICANTIDAD")
    private int noCantidad;
    
    @PropiedadMap(campo="FCCOSTOPRENDA")
    private String cadenaCostoPrenda;
    
    @PropiedadMap(campo="FISEMANA")
    private int noSemana;
    
    @PropiedadMap(campo="FCSALDOPORPAGAR")   
    private String cadenaSaldoPorPagar;
        
    @PropiedadMap(campo="FCPAGOSEMANAL") 
    private String cadenaPagoSemanal;
    
    @PropiedadMap(campo="FCFECHAPAGO") 
    private String cadenaFechaPago;
    
    @PropiedadMap(campo="FCNOMBREIMAGEN")
    private String cadenaNombreImagen;

    public int getNoPedido() {
        return noPedido;
    }

    public void setNoPedido(int noPedido) {
        this.noPedido = noPedido;
    }

    public String getCadenaSku() {
        return cadenaSku;
    }

    public void setCadenaSku(String cadenaSku) {
        this.cadenaSku = cadenaSku;
    }

    public String getCadenaDescripcion() {
        return cadenaDescripcion;
    }

    public void setCadenaDescripcion(String cadenaDescripcion) {
        this.cadenaDescripcion = cadenaDescripcion;
    }

    public int getNoTipoPrenda() {
        return noTipoPrenda;
    }

    public void setNoTipoPrenda(int noTipoPrenda) {
        this.noTipoPrenda = noTipoPrenda;
    }

    public String getCadenaPagado() {
        return cadenaPagado;
    }

    public void setCadenaPagado(String cadenaPagado) {
        this.cadenaPagado = cadenaPagado;
    }

    public int getNoCantidad() {
        return noCantidad;
    }

    public void setNoCantidad(int noCantidad) {
        this.noCantidad = noCantidad;
    }

    public String getCadenaCostoPrenda() {
        return cadenaCostoPrenda;
    }

    public void setCadenaCostoPrenda(String cadenaCostoPrenda) {
        this.cadenaCostoPrenda = cadenaCostoPrenda;
    }

    public int getNoSemana() {
        return noSemana;
    }

    public void setNoSemana(int noSemana) {
        this.noSemana = noSemana;
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

    public String getCadenaFechaPago() {
        return cadenaFechaPago;
    }

    public void setCadenaFechaPago(String cadenaFechaPago) {
        this.cadenaFechaPago = cadenaFechaPago;
    }

    public String getCadenaNombreImagen() {
        return cadenaNombreImagen;
    }

    public void setCadenaNombreImagen(String cadenaNombreImagen) {
        this.cadenaNombreImagen = cadenaNombreImagen;
    }        

}