/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOInformacionPedidoDescuento;
import com.elektra.uniformes.comercio.Modelo.InformacionPedidoDescuento;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("negocioInformacionPedidoDescuento")
public class NegocioInformacionPedidoDescuento {
    @Autowired
    @Qualifier("daoInformacionPedidoDescuento")
    private DAOInformacionPedidoDescuento daoInformacionPedidoDescuento;

    public ArrayList<InformacionPedidoDescuento> getInformacionPedidosDescuentos(Integer folioSolicitud, Integer numeroPedido) throws Exception {
        return daoInformacionPedidoDescuento.getInformacionPedidoDescuento(folioSolicitud, numeroPedido);
    }

}
