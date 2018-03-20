/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.controller;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.uniformes.comercio.controller.negocio.NegocioInformacionPedidoDescuento;
import com.elektra.uniformes.comercio.controller.negocio.NegocioPedidoDescuento;
import com.elektra.uniformes.comercio.controller.negocio.NegocioSolicitudVoluntaria;
import com.elektra.uniformes.comercio.response.Respuesta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author kortizl
 */
@Controller
@RequestMapping("/solicitudes_voluntarias")
public class ControllerDescuento{

    @Autowired
    @Qualifier("negocioSolicitudVoluntaria")
    private NegocioSolicitudVoluntaria negocioSolicitudVoluntaria;
        
    @RequestMapping(value = "/{numeroEmpleado}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getSolicitudesVoluntarias(@PathVariable("numeroEmpleado") Integer numeroEmpleado) {        
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioSolicitudVoluntaria.getSolicitudesVoluntarias(numeroEmpleado,5));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getInformacionSolicitudDescuento " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }

    @Autowired
    @Qualifier("negocioPedidoDescuento")
    private NegocioPedidoDescuento negocioPedidoDescuento;
        
    @RequestMapping(value = "/{numeroEmpleado}/pedidos_descuentos/{numeroFolioSolicitud}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getPedidosDescuentos(@PathVariable("numeroFolioSolicitud") Integer numeroFolioSolicitud) {        
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioPedidoDescuento.getPedidosDescuentos(numeroFolioSolicitud));            
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getPedidosDescuentos " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    
    @Autowired
    @Qualifier("negocioInformacionPedidoDescuento")
    private NegocioInformacionPedidoDescuento negocioInformacionPedidoDescuento;
        
    @RequestMapping(value = "/{numeroEmpleado}/pedidos_descuentos/{numeroFolioSolicitud}/informacion/{numeroPedido}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getInformacionPedidosDescuentos(@PathVariable("numeroFolioSolicitud") Integer numeroFolioSolicitud,@PathVariable("numeroPedido") Integer numeroPedido ) {        
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioInformacionPedidoDescuento.getInformacionPedidosDescuentos(numeroFolioSolicitud,numeroPedido));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getInformacionPedidosDescuentos " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
}
