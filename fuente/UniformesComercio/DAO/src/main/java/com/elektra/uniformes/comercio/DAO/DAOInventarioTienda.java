/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.uniformes.comercio.DAO.clienteWS.InventarioCD.IntfCONSULINVENTARIOService;
import com.elektra.uniformes.comercio.DAO.clienteWS.InventarioCD.Parametros;
import com.elektra.uniformes.comercio.DAO.clienteWS.InventarioCD.ParametrosEntrada;
import com.elektra.uniformes.comercio.DAO.clienteWS.InventarioCD.PortType;
import java.net.URL;
import javax.xml.namespace.QName;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("daoInventarioTienda")
public class DAOInventarioTienda {

    public int getInventario(int tienda, int sku) throws Exception{
        int inv = 0;
        try {
            ParametrosEntrada params = new ParametrosEntrada();
            params.setTienda(String.valueOf(tienda));
            params.setSku(String.valueOf(sku));
            ClassLoader classloader = Thread.currentThread().getContextClassLoader();
            URL wsdlLocation = classloader.getResource("WS_INVENTARIO.wsdl");
            QName qName = new QName("http://servicios.elektra.com.mx/ekt/1.0/inventario", "intfCONSUL_INVENTARIO-service");
            IntfCONSULINVENTARIOService wsInv = new IntfCONSULINVENTARIOService(wsdlLocation, qName);
            PortType port = wsInv.getIntfwsCONSULINVENTARIOEndpoint1();
            Parametros respInv = port.consulINVENTARIOOp(params);
            inv = Integer.valueOf(respInv.getQTY());
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getInventario " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getInventario " + e.getMessage());
        }
        return inv;
    }
}
