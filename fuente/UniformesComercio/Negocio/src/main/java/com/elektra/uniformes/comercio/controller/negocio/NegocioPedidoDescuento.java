/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOPedidoDescuento;
import com.elektra.uniformes.comercio.Modelo.PedidoDescuento;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */

@Component("negocioPedidoDescuento")
public class NegocioPedidoDescuento {

    @Autowired
    @Qualifier("daoPedidoDescuento")
    private DAOPedidoDescuento daoPedidoDescuento;

    public ArrayList<PedidoDescuento> getPedidosDescuentos(Integer numeroFolioSolicitud) throws Exception {
        return daoPedidoDescuento.getPedidosDescuentos(numeroFolioSolicitud);
    }

}
