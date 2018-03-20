/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOReporte;
import com.elektra.uniformes.comercio.Modelo.Pedido;
import com.elektra.uniformes.comercio.Modelo.Reporte;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("negocioReporte")
public class NegocioReporte {

    @Autowired
    @Qualifier("daoReporte")
    private DAOReporte daoReporte;

    public ArrayList<Reporte> getReporte(){
        return daoReporte.getReporte();
    }
    
    public Pedido getReportePedido(int idPedido){
        return daoReporte.getReportePedido(idPedido);
    }
}
