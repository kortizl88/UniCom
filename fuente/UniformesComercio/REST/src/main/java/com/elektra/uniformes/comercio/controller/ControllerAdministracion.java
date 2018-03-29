/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.uniformes.comercio.Modelo.CargaSemestral;
import com.elektra.uniformes.comercio.Modelo.EmpleadoAcceso;
import com.elektra.uniformes.comercio.Modelo.ReporteReq;
import com.elektra.uniformes.comercio.Modelo.SolicitudDTO;
import com.elektra.uniformes.comercio.controller.negocio.NegocioAdministrador;
import com.elektra.uniformes.comercio.controller.negocio.NegocioAdministradorCargas;
import com.elektra.uniformes.comercio.controller.negocio.NegocioAdministradorReporte;
import com.elektra.uniformes.comercio.response.Respuesta;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
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

    @RequestMapping(value = "/datos/acceso", method = RequestMethod.POST)
    public @ResponseBody
    Respuesta getdatosEmpleado(EmpleadoAcceso acceso) {
        Respuesta r = new Respuesta();
        try {
            if (negocioAdministrador.validaAcceso(acceso)) {
                r.setRespuesta(negocioAdministrador.getDatosAdministrador(acceso.getUsuario()));
                r.setError(false);
                r.setMensaje("Consulta obtenida correctamente");
            } else {
                r.setRespuesta( null );
                r.setError(true);
                r.setMensaje("Verifique su usuario y contraseña");
            }
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

    @RequestMapping(value = "/carga", method = RequestMethod.POST)
    public @ResponseBody
    Respuesta actualizaCarga(@RequestBody CargaSemestral carga) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioAdministradorCargas.actualizaCarga(carga));
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

    @RequestMapping(value = "/reporte/negocios", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getNegocios() {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioAdministradorCargas.getNegocios());
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getNegocios " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }

    @RequestMapping(value = "/reporte", method = RequestMethod.POST)
    public @ResponseBody
    Respuesta consultaReporte(@RequestBody ReporteReq reporteReqa) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioAdministradorReporte.obtieneReporte(reporteReqa));
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

    @RequestMapping(value = "/reporte/generar/{indicaFecha}/{fechaInicio}/{fechaFin}/{indCarga}/{carga}/{indEstatus}/{estatus}/{indTienda}/{tienda}/{indEmpleado}/{empleado}", method = RequestMethod.GET)
    public void generaReporteExcel(HttpServletResponse response, @PathVariable("indicaFecha") int indicaFecha,
            @PathVariable("fechaInicio") String fechaInicio,
            @PathVariable("fechaFin") String fechaFin,
            @PathVariable("indCarga") int indCarga,
            @PathVariable("carga") String carga,
            @PathVariable("indEstatus") int indEstatus,
            @PathVariable("estatus") String estatus,
            @PathVariable("indTienda") int indTienda,
            @PathVariable("tienda") int tienda,
            @PathVariable("indEmpleado") int indEmpleado,
            @PathVariable("empleado") int empleado) {
        try {
            File file = negocioAdministradorReporte.generarReporteExcel(indicaFecha, fechaInicio, fechaFin, indCarga, carga, indEstatus, estatus, indTienda, tienda, indEmpleado, empleado);
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", String.format("inline; filename=\"" + file.getName() + "\""));
            response.setContentLength((int) file.length());
            InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
            FileCopyUtils.copy(inputStream, response.getOutputStream());
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getCargas " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
    }

    @RequestMapping(value = "/reporte/seguimiento/solicitud/{solicitud}/detalleproc/{detalleproc}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getSeguimientoSolicitud(@PathVariable("solicitud") int solicitud, @PathVariable("detalleproc") int detalleproc) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioAdministradorReporte.getSeguimientoSolicitud(solicitud, detalleproc));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getSeguimientoSolicitud " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
}
