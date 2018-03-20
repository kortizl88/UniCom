/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOSolicitudVoluntaria;
import com.elektra.uniformes.comercio.Modelo.SolicitudVoluntaria;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 */
@Component("negocioSolicitudVoluntaria")
public class NegocioSolicitudVoluntaria{

    @Autowired
    @Qualifier("daoSolicitudVoluntaria")
    private DAOSolicitudVoluntaria daoSolicitudVoluntaria;
   
    public ArrayList<SolicitudVoluntaria> getSolicitudesVoluntarias(Integer numeroEmpleado, Integer numeroSolicitudes) throws Exception {
        return daoSolicitudVoluntaria.getSolicitudesVoluntarias(numeroEmpleado, numeroSolicitudes);
    }

}