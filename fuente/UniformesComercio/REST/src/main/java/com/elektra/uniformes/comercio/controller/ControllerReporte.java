/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller;

import com.elektra.uniformes.comercio.controller.negocio.NegocioReporte;
import com.elektra.uniformes.comercio.response.Respuesta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author kortizl
 */
@org.springframework.stereotype.Controller
@RequestMapping("/reporte")
public class ControllerReporte {
    
    @Autowired
    @Qualifier("negocioReporte")
    private NegocioReporte negocioReporte;
    
    @RequestMapping(value= "/" , method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getReporte() {
        Respuesta r = new Respuesta();
        r.setRespuesta(negocioReporte.getReporte());
        r.setError(false);
        r.setMensaje("Consulta obtenida correctamente");
        return r;
    }
    
    @RequestMapping(value= "/filtro" , method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getReporteFiltro( @RequestParam(value="fechaInicio", required=false) String fechaInicio
            ,@RequestParam(value="fechaFin", required=false) String fechaFin
            ,@RequestParam(value="empleado", required=false) Integer empleado
            ,@RequestParam(value="remision", required=false) Integer remision
            ,@RequestParam(value="pedido", required=false) Integer pedido
            ,@RequestParam(value="fechaInicioRemision", required=false) String fechaInicioRemision
            ,@RequestParam(value="fechaFinRemision", required=false) String fechaFinRemision
            ,@RequestParam(value="tienda", required=false) Integer tienda
            ,@RequestParam(value="sku", required=false) Integer sku) {
        Respuesta r = new Respuesta();
        
        System.out.println("parametros: " + fechaInicio + "-" + fechaFin + "-" + tienda);
        r.setRespuesta(negocioReporte.getReporte());
        r.setError(false);
        r.setMensaje("Consulta obtenida correctamente");
        return r;
    }
    
    @RequestMapping(value= "/pedido/{idPedido}" , method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getReportePedido(@PathVariable int idPedido) {
        Respuesta r = new Respuesta();
        r.setRespuesta(negocioReporte.getReportePedido(idPedido));
        r.setError(false);
        r.setMensaje("Consulta obtenida correctamente");
        return r;
    }
    
}
