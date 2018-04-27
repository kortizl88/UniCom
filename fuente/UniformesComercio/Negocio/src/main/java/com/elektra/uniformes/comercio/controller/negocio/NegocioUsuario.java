/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOUsuario;
import com.elektra.uniformes.comercio.Modelo.Menu;
import com.elektra.uniformes.comercio.Modelo.Usuario;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("negocioUsuario")
public class NegocioUsuario {

    @Autowired
    @Qualifier("daoUsuario")
    private DAOUsuario daoUsuario;

    public Usuario getInformacionUsuario(int numEmp, int tienda) throws Exception{
        return daoUsuario.getInformacionUsuario(numEmp , tienda);
    }
    
    public ArrayList<Menu> getMenuFuncionNegocio(int noFuncionSap,int noNegocio) throws Exception {
        return daoUsuario.getMenuFuncionNegocio(noFuncionSap, noNegocio);
    }
}
