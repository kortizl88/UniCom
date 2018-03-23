/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOAdministradorReporte;
import com.elektra.uniformes.comercio.Modelo.EstatusSolicitud;
import com.elektra.uniformes.comercio.Modelo.Tienda;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("negocioAdministradorReporte")
public class NegocioAdministradorReporte {

    @Autowired
    @Qualifier("daoAdministradorReporte")
    private DAOAdministradorReporte daoAdministradorReporte;

    public ArrayList<EstatusSolicitud> getEstatus() throws Exception {
        return daoAdministradorReporte.getEstatus();
    }

    public ArrayList<Tienda> getTiendas() throws Exception {
        return daoAdministradorReporte.getTiendas();
    }
}
