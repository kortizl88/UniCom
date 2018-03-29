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
    @PropiedadMap(campo = "FCPORCSOLICITUD")
    private String cadenaPorcientoSolicitado;
    @PropiedadMap(campo = "FCPORCATENDIDOCD")
    private String cadenaPorcientoAtendido;
    @PropiedadMap(campo = "FCPORCRECIBIDOTIENDA")
    private String cadenaPorcientoRecibido;
    @PropiedadMap(campo = "FCPORCCAMINOTIENDA")
    private String cadenaPorcientoCamino;
    @PropiedadMap(campo = "FCPORCENTREGADO")
    private String cadenaPorcientoEntregado;

    /**
     * @return the cadenaPorcientoCancelado
     */
    public String getCadenaPorcientoCancelado() {
        return cadenaPorcientoCancelado;
    }

    /**
     * @param cadenaPorcientoCancelado the cadenaPorcientoCancelado to set
     */
    public void setCadenaPorcientoCancelado(String cadenaPorcientoCancelado) {
        this.cadenaPorcientoCancelado = cadenaPorcientoCancelado;
    }

    /**
     * @return the cadenaPorcientoAtendido
     */
    public String getCadenaPorcientoAtendido() {
        return cadenaPorcientoAtendido;
    }

    /**
     * @param cadenaPorcientoAtendido the cadenaPorcientoAtendido to set
     */
    public void setCadenaPorcientoAtendido(String cadenaPorcientoAtendido) {
        this.cadenaPorcientoAtendido = cadenaPorcientoAtendido;
    }

    /**
     * @return the cadenaPorcientoRecibido
     */
    public String getCadenaPorcientoRecibido() {
        return cadenaPorcientoRecibido;
    }

    /**
     * @param cadenaPorcientoRecibido the cadenaPorcientoRecibido to set
     */
    public void setCadenaPorcientoRecibido(String cadenaPorcientoRecibido) {
        this.cadenaPorcientoRecibido = cadenaPorcientoRecibido;
    }

    /**
     * @return the cadenaPorcientoCamino
     */
    public String getCadenaPorcientoCamino() {
        return cadenaPorcientoCamino;
    }

    /**
     * @param cadenaPorcientoCamino the cadenaPorcientoCamino to set
     */
    public void setCadenaPorcientoCamino(String cadenaPorcientoCamino) {
        this.cadenaPorcientoCamino = cadenaPorcientoCamino;
    }

    /**
     * @return the cadenaPorcientoEntregado
     */
    public String getCadenaPorcientoEntregado() {
        return cadenaPorcientoEntregado;
    }

    /**
     * @param cadenaPorcientoEntregado the cadenaPorcientoEntregado to set
     */
    public void setCadenaPorcientoEntregado(String cadenaPorcientoEntregado) {
        this.cadenaPorcientoEntregado = cadenaPorcientoEntregado;
    }

    /**
     * @return the cadenaPorcientoSolicitado
     */
    public String getCadenaPorcientoSolicitado() {
        return cadenaPorcientoSolicitado;
    }

    /**
     * @param cadenaPorcientoSolicitado the cadenaPorcientoSolicitado to set
     */
    public void setCadenaPorcientoSolicitado(String cadenaPorcientoSolicitado) {
        this.cadenaPorcientoSolicitado = cadenaPorcientoSolicitado;
    }

}
