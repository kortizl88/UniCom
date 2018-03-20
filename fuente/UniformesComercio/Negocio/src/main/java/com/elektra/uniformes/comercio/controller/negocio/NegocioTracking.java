/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOTracking;
import com.elektra.uniformes.comercio.Modelo.Tracking;
import java.sql.Date;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 */
@Component("negocioTracking")
public class NegocioTracking {

    @Autowired
    @Qualifier("daoTracking")
    private DAOTracking daoTracking;
   
    public ArrayList<Tracking> getTrackings(Integer folioSolicitud) throws Exception {
        return daoTracking.getTrackings(folioSolicitud);
    }

}
