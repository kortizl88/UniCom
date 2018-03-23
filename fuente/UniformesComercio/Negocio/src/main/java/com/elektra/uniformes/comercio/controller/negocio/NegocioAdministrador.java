/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOAdministrador;
import com.elektra.uniformes.comercio.Modelo.Administrador;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("negocioAdministrador")
public class NegocioAdministrador {
    
    @Autowired
    @Qualifier("daoAdministrador")
    private DAOAdministrador daoAdministrador;
    
    public Administrador getDatosAdministrador(int numEmpleado) throws Exception {
        return daoAdministrador.getDatosAdministrador(numEmpleado);
    }
}
