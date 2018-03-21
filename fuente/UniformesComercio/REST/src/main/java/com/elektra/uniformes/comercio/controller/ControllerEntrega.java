/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.uniformes.comercio.Modelo.ConfirmacionEntrega;
import com.elektra.uniformes.comercio.Modelo.EntregaDTO;
import com.elektra.uniformes.comercio.controller.negocio.NegocioEntrega;
import com.elektra.uniformes.comercio.controller.negocio.NegocioSolicitud;
import com.elektra.uniformes.comercio.response.Respuesta;
import java.util.ArrayList;
import java.util.Arrays;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author kortizl
 */
@Controller
@RequestMapping("/entrega")
public class ControllerEntrega {
    
    @Autowired
    @Qualifier("negocioEntrega")
    private NegocioEntrega negocioEntrega;
    
    @RequestMapping(value = "/pendientes/{empleado}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getPendientesEntrega(@PathVariable("empleado") int empleado) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioEntrega.getPendientesEntrega(empleado));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getPendientesEntrega " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    
    @RequestMapping(value = "/", method = RequestMethod.POST)
    public @ResponseBody
    Respuesta postConfirmacionEntrega(@RequestBody EntregaDTO entrega) {
        Respuesta r = new Respuesta();
        try {           
            negocioEntrega.postConfirmacionEntrega(entrega);
            r.setRespuesta(entrega);
            r.setError(false);
            r.setMensaje("Entregado Correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getPendientesEntrega " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    /*    
    @RequestMapping(value = "/", method = RequestMethod.POST)
    public @ResponseBody Respuesta guardaSolicitud(@RequestBody SolicitudDTO[] solicitud ) {     
        Respuesta r = new Respuesta();
        try {
            ArrayList<SolicitudDTO> solicitudes = new ArrayList<SolicitudDTO>();
            solicitudes.add(solicitud[0]);
            r.setRespuesta(negocioSolicitud.guardaSolicitud(solicitudes));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getMenuUsuario " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    */
}
