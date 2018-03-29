/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.uniformes.comercio.Modelo.DetalleEntrega;
import com.elektra.uniformes.comercio.Modelo.EntregaDTO;
import com.elektra.uniformes.comercio.Modelo.Pedido;
import com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda.ActPedidos;
import com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda.ActualizaPedido;
import com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda.ArrayOfActPedidos;
import com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda.ArrayOfint;
import com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda.AtualizaPedidos;
import com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda.IWSUniformes;
import com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda.ObjectFactory;
import com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda.SalidaDatos;
import com.elektra.uniformes.comercio.cron.dao.clienteWS.tienda.WSUniformes;
import com.elektra.uniformes.comercio.utilerias.TiendaCifrado;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import javax.xml.namespace.QName;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("daoEntregaTienda")
public class DAOEntregaTienda {

    public void descargaPedidoTienda(EntregaDTO solicitud) throws Exception {
        try {
            for (DetalleEntrega p : solicitud.getPedidos()) {
                ObjectFactory f = new ObjectFactory();
                ActualizaPedido actPedido = new ActualizaPedido();
                AtualizaPedidos ap = new AtualizaPedidos();

                List<Integer> skus = new ArrayList<Integer>();
                /*skus * cantidad*/
                for (int x = 0; x < p.getCantidad(); x++) {
                    skus.add(new Integer(p.getSku()));
                }

                ArrayOfActPedidos arrayPedidos = new ArrayOfActPedidos();

                ActPedidos actPedidos = new ActPedidos();
                actPedidos.setNumEmpleado(f.createActPedidosNumEmpleado(String.valueOf(solicitud.getEmpleado())));
                actPedidos.setNumPedido(p.getPedido());
                actPedidos.setObservaciones(f.createActPedidosObservaciones("Entregado"));
                actPedidos.setStatus(3);
                ArrayOfint arrayint = new ArrayOfint();
                arrayint.setInt(skus);
                actPedidos.setSKU(f.createActPedidosSKU(arrayint));
                String keyWs = TiendaCifrado.encriptaLlaveWsTienda(String.valueOf(solicitud.getNoTienda()), p.getTiendaIP(), String.valueOf(solicitud.getEmpleado()), "1");
                ap.setKeyWs(f.createReciveDatosKeyWs(keyWs));
                ap.setTipoUsuario(3);
                ap.setTipoSistema(1);
                ap.setTipoNegocio(3);
                arrayPedidos.getActPedidos().add(actPedidos);
                ap.setModifPed(f.createArrayOfActPedidos(arrayPedidos));
                actPedido.setDatosP(f.createActualizaPedidoDatosP(ap));
                WSUniformes wsTienda = new WSUniformes(new URL("http://"+p.getTiendaIP()+"/WebServicioTienda/Elektra.Servicios.Datos.AdmonUniformes.WSUniformes.svc?wsdl"), new QName("http://tempuri.org/", "WSUniformes"));
                IWSUniformes port = wsTienda.getPort(IWSUniformes.class);
                SalidaDatos respAct = port.actualizaPedido(ap);
                p.setErrorEntrega(false);
                p.setMensaje("Descargado correctamente en tienda");
                if (respAct.getBanderaError() != 0) {
                    p.setMensaje(respAct.getMsjSalida().getValue());
                    if (p.getMensaje().contains("no puede pasar dos veces por el mismo status 3")) {
                        p.setErrorEntrega(false);
                    } else {
                        p.setErrorEntrega(true);
                        LogeoDAO.getInstancia().logExcepcion("Ocurrio un error al realizar la descarga de inventario en la tienda (WSTienda): solicitud -> " + p.getSolicitud() + " pedido - >" + p.getPedido() + " mensaje: " + p.getMensaje());
                    }
                }
            }

        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("Ocurrio un error al realizar la descarga de inventario en la tienda : " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: descargaPedidoTienda " + e.getMessage());
        }
    }
}
