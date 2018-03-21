/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOEntrega;
import com.elektra.uniformes.comercio.DAO.DAOInformacionPedidoDescuento;
import com.elektra.uniformes.comercio.Modelo.ConfirmacionEntrega;
import com.elektra.uniformes.comercio.Modelo.EntregaDTO;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("negocioEntrega")
public class NegocioEntrega {

    @Autowired
    @Qualifier("daoEntrega")
    private DAOEntrega daoEntrega;

    public ArrayList<EntregaDTO> getPendientesEntrega(int numEmp) throws Exception {
        return daoEntrega.getPendientesEntrega(numEmp);
    }

    public void postConfirmacionEntrega(EntregaDTO confirmaciones) throws Exception {
        daoEntrega.postConfirmacionEntrega(confirmaciones);
    }
}
