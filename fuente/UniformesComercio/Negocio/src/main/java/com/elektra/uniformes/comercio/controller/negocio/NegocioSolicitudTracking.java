/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOSolicitud;
import com.elektra.uniformes.comercio.DAO.DAOSolicitudTracking;
import com.elektra.uniformes.comercio.Modelo.Solicitud;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 */
@Component("negocioSolicitudTracking")
public class NegocioSolicitudTracking {

    @Autowired
    @Qualifier("daoSolicitudTracking")
    private DAOSolicitudTracking daoSolicitudTracking;
   
    public ArrayList<Solicitud> getSolicitudes(Integer numeroEmpleado, Integer numeroSolicitudes) throws Exception {
        return daoSolicitudTracking.getSolicitudes(numeroEmpleado, numeroSolicitudes);
    }

}
