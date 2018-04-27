/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.uniformes.comercio.controller.negocio.NegocioUsuario;
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
@RequestMapping("/usuario")
public class ControllerUsuario {

    @Autowired
    @Qualifier("negocioUsuario")
    private NegocioUsuario negocioUsuario;

    @RequestMapping(value = "/{numEmp}/tienda/{tienda}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getInformacionUsuario(@PathVariable("numEmp") int numEmp,@PathVariable("tienda") int tienda ) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioUsuario.getInformacionUsuario(numEmp,tienda));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getInformacionUsuario " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
    
    @RequestMapping(value = "/{numEmp}/funcion/{noFuncion}/negocio/{noNegocio}", method = RequestMethod.GET)
    public @ResponseBody
    Respuesta getMenuFuncionNegocio(@PathVariable("noFuncion") int noFuncion, @PathVariable("noNegocio") int noNegocio) {
        Respuesta r = new Respuesta();
        try {
            r.setRespuesta(negocioUsuario.getMenuFuncionNegocio(noFuncion,noNegocio));
            r.setError(false);
            r.setMensaje("Consulta obtenida correctamente");
        } catch (Exception e) {
            r.setError(true);
            r.setMensaje(e.getMessage());
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getMenuFuncionNegocio " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
        }
        return r;
    }
}
