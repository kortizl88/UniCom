/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.Modelo;

import com.elektra.mapper.anotaciones.PropiedadMap;


public class Avance {
    
    @PropiedadMap(campo = "FCPORCCANCELADO")
    private String cadenaPorcientoCancelado;
        
    @PropiedadMap(campo = "FCPORCPENDIENTE")
    private String cadenaPorcientoPendiente;
    
    @PropiedadMap(campo = "FCPORCSOLICITADO")   
    private String cadenaPorcientoSolicitado;
    
    @PropiedadMap(campo = "FCPORCATENDIDO")
    private String cadenaPorcientoAtendido;
    
    @PropiedadMap(campo = "FCPORCRECIBIDO")
    private String cadenaPorcientoRecibido;
    
    @PropiedadMap(campo = "FCPORCCAMINO")
    private String cadenaPorcientoCamino;
    
    @PropiedadMap(campo = "FCPORCENTREGADO")
    private String cadenaPorcientoEntregado;

    public String getCadenaPorcientoCancelado() {
        return cadenaPorcientoCancelado;
    }

    public void setCadenaPorcientoCancelado(String cadenaPorcientoCancelado) {
        this.cadenaPorcientoCancelado = cadenaPorcientoCancelado;
    }

    public String getCadenaPorcientoPendiente() {
        return cadenaPorcientoPendiente;
    }

    public void setCadenaPorcientoPendiente(String cadenaPorcientoPendiente) {
        this.cadenaPorcientoPendiente = cadenaPorcientoPendiente;
    }

    public String getCadenaPorcientoSolicitado() {
        return cadenaPorcientoSolicitado;
    }

    public void setCadenaPorcientoSolicitado(String cadenaPorcientoSolicitado) {
        this.cadenaPorcientoSolicitado = cadenaPorcientoSolicitado;
    }

    public String getCadenaPorcientoAtendido() {
        return cadenaPorcientoAtendido;
    }

    public void setCadenaPorcientoAtendido(String cadenaPorcientoAtendido) {
        this.cadenaPorcientoAtendido = cadenaPorcientoAtendido;
    }

    public String getCadenaPorcientoRecibido() {
        return cadenaPorcientoRecibido;
    }

    public void setCadenaPorcientoRecibido(String cadenaPorcientoRecibido) {
        this.cadenaPorcientoRecibido = cadenaPorcientoRecibido;
    }

    public String getCadenaPorcientoCamino() {
        return cadenaPorcientoCamino;
    }

    public void setCadenaPorcientoCamino(String cadenaPorcientoCamino) {
        this.cadenaPorcientoCamino = cadenaPorcientoCamino;
    }

    public String getCadenaPorcientoEntregado() {
        return cadenaPorcientoEntregado;
    }

    public void setCadenaPorcientoEntregado(String cadenaPorcientoEntregado) {
        this.cadenaPorcientoEntregado = cadenaPorcientoEntregado;
    }
    
}
