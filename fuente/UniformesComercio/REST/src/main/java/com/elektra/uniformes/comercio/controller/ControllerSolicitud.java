/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.uniformes.comercio.Modelo.SolicitudDTO;
import com.elektra.uniformes.comercio.controller.negocio.NegocioSolicitud;
import com.elektra.uniformes.comercio.response.Respuesta;
import java.util.ArrayList;
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
@RequestMapping("/solicitud")
public class ControllerSolicitud {

    @Autowired
    @Qualifier("negocioSolicitud")
    private NegocioSolicitud negocioSolicitud;
    
    @RequestMapping(value = "/tienda/pais/{pais}/canal/{canal}/sucursal/{tienda}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getInfoTienda(@PathVariable("pais") int pais, @PathVariable("canal") int canal,@PathVariable("tienda") int tienda) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioSolicitud.getInfoTienda(pais, canal, tienda));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getInfoTienda " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    
    @RequestMapping(value = "/kit/empleado/{numEmp}/tiposolicitud/{tipo}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getKitEmpleado(@PathVariable("numEmp") int numEmp, @PathVariable("tipo") int tipo) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioSolicitud.getKitEmpleado(numEmp,tipo));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getKitEmpleado " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }

    @RequestMapping(value = "/kit/pais/{pais}/canal/{canal}/sucursal/{tienda}/tiposolicitud/{tipo}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getKitEmpleadosTienda(@PathVariable("pais") int pais, @PathVariable("canal") int canal,@PathVariable("tienda") int tienda, @PathVariable("tipo") int tipo) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioSolicitud.getKitEmpleadosTienda(pais , canal, tienda, tipo));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getKitEmpleadosTienda " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    
    @RequestMapping(value = "/", method = RequestMethod.POST)
    public @ResponseBody Respuesta guardaSolicitud(@RequestBody SolicitudDTO[] arregloSolicitudes) {     
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioSolicitud.guardaSolicitud(arregloSolicitudes));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: guardaSolicitud " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    
    @RequestMapping(value = "/tiendascercanas/pais/{pais}/canal/{canal}/sucursal/{tienda}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getTiendasCercanas(@PathVariable("pais") int pais, @PathVariable("canal") int canal,@PathVariable("tienda") int tienda) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioSolicitud.getTiendasCercanas(pais, canal, tienda));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getTiendasCercanas " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    
    @RequestMapping(value = "/nuevoingreso/pais/{pais}/canal/{canal}/ceco/{ceco}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getNuevosIngreso(@PathVariable("pais") int pais, @PathVariable("canal") int canal, @PathVariable("ceco") int ceco) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioSolicitud.getNuevosIngreso(pais, canal, ceco));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getNuevosIngreso " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
}
