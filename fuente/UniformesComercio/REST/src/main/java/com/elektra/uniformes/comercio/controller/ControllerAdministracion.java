/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.uniformes.comercio.controller.negocio.NegocioAdministrador;
import com.elektra.uniformes.comercio.controller.negocio.NegocioAdministradorCargas;
import com.elektra.uniformes.comercio.controller.negocio.NegocioAdministradorReporte;
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
@RequestMapping("/administracion")
public class ControllerAdministracion {

    @Autowired
    @Qualifier("negocioAdministrador")
    private NegocioAdministrador negocioAdministrador;
    @Autowired
    @Qualifier("negocioAdministradorCargas")
    private NegocioAdministradorCargas negocioAdministradorCargas;
    @Autowired
    @Qualifier("negocioAdministradorReporte")
    private NegocioAdministradorReporte negocioAdministradorReporte;

    @RequestMapping(value = "/datos/empleado/{empleado}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getdatosEmpleado(@PathVariable("empleado") int empleado) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioAdministrador.getDatosAdministrador(empleado));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getdatosEmpleado " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }

    @RequestMapping(value = "/carga", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getCargas() {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioAdministradorCargas.getCargas());
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getCargas " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }

    @RequestMapping(value = "/reporte/estatus", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getReporteEstatus() {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioAdministradorReporte.getEstatus());
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getReporteEstatus " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    
    @RequestMapping(value = "/reporte/tiendas", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getReporteTiendas() {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioAdministradorReporte.getTiendas());
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getReporteTiendas " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
}
