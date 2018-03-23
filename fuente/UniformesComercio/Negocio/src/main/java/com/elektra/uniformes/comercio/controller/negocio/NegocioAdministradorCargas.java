/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOAdministradorCargas;
import com.elektra.uniformes.comercio.Modelo.CargaSemestral;
import com.elektra.uniformes.comercio.Modelo.Tienda;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("negocioAdministradorCargas")
public class NegocioAdministradorCargas {

    @Autowired
    @Qualifier("daoAdministradorCargas")
    private DAOAdministradorCargas daoAdministradorCargas;

    public ArrayList<CargaSemestral> getCargas() throws Exception {
        return daoAdministradorCargas.getCargas();
    }
    
}
