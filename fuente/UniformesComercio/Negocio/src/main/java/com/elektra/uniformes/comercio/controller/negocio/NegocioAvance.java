/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOAvance;
import com.elektra.uniformes.comercio.Modelo.Avance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;


/**
 *
 * @author kortizl
 */
@Component("negocioAvance")
public class NegocioAvance {

    @Autowired
    @Qualifier("daoAvance")
    private DAOAvance daoAvance;

    public Avance getAvance(Integer folioSolicitud) throws Exception{
        return daoAvance.getAvance(folioSolicitud);
    }
}
