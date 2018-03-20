/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.controller;
import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.uniformes.comercio.controller.negocio.NegocioAvance;
import com.elektra.uniformes.comercio.controller.negocio.NegocioSolicitudTracking;
import com.elektra.uniformes.comercio.controller.negocio.NegocioTracking;
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
@RequestMapping("/solicitudes")
public class ControllerSolicitudTracking{

    @Autowired
    @Qualifier("negocioSolicitudTracking")
    private NegocioSolicitudTracking negocioSolicitudTracking;
        
    @RequestMapping(value = "/{numeroEmpleado}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getSolicitudes(@PathVariable("numeroEmpleado") Integer numeroEmpleado) {        
        Respuesta r = new Respuesta();        

        try {
            r.setRespuesta(negocioSolicitudTracking.getSolicitudes(numeroEmpleado,5));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getSolicitudes " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    
    @Autowired
    @Qualifier("negocioTracking")
    private NegocioTracking negocioTracking;
        
    @RequestMapping(value = "/{numeroEmpleado}/tracking/{folioSolicitud}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getTrackings(@PathVariable("folioSolicitud") Integer folioSolicitud) {        
        Respuesta r = new Respuesta();        

        try {
            r.setRespuesta(negocioTracking.getTrackings(folioSolicitud));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getTrackings " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    
        
    @Autowired
    @Qualifier("negocioAvance")
    private NegocioAvance negocioAvance;
        
    @RequestMapping(value = "/{numeroEmpleado}/tracking/{folioSolicitud}/avance", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getAvance(@PathVariable("folioSolicitud") Integer folioSolicitud) {        
        Respuesta r = new Respuesta();        

        try {
            r.setRespuesta(negocioAvance.getAvance(folioSolicitud));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getAvance " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
   

}
