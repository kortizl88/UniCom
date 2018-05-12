/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.uniformes.comercio.DAO.clienteWS.Tienda.ActPedidos;
import com.elektra.uniformes.comercio.DAO.clienteWS.Tienda.ActualizaPedido;
import com.elektra.uniformes.comercio.DAO.clienteWS.Tienda.ActualizaPedidoResponse;
import com.elektra.uniformes.comercio.DAO.clienteWS.Tienda.ModifPed;
import com.elektra.uniformes.comercio.DAO.clienteWS.Tienda.ArrayOfint;
import com.elektra.uniformes.comercio.DAO.clienteWS.Tienda.AtualizaPedidos;
import com.elektra.uniformes.comercio.DAO.clienteWS.Tienda.IWSUniformes;
import com.elektra.uniformes.comercio.DAO.clienteWS.Tienda.ObjectFactory;
import com.elektra.uniformes.comercio.DAO.clienteWS.Tienda.SalidaDatos;
import com.elektra.uniformes.comercio.DAO.clienteWS.Tienda.WSUniformes;
import com.elektra.uniformes.comercio.Modelo.DetalleEntrega;
import com.elektra.uniformes.comercio.Modelo.EntregaDTO;
import com.elektra.uniformes.comercio.Modelo.Pedido;
import com.elektra.uniformes.comercio.utilerias.SoapPeticionRespuestaHandler;
import com.elektra.uniformes.comercio.utilerias.TiendaCifrado;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.JAXBElement;
import javax.xml.namespace.QName;
import javax.xml.ws.BindingProvider;
import javax.xml.ws.handler.Handler;
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
                
                List<ActPedidos> modifPed = new ArrayList<ActPedidos>();
                ActPedidos actPedidos = new ActPedidos();
                actPedidos.setNumEmpleado(f.createActPedidosNumEmpleado(String.valueOf(solicitud.getEmpleado())));
                actPedidos.setNumPedido(p.getPedido());
                actPedidos.setObservaciones(f.createActPedidosObservaciones("Entregado"));
                actPedidos.setStatus(3);
                ArrayOfint arrayint = new ArrayOfint();
                arrayint.setInt(skus);
                actPedidos.setSKU(f.createActPedidosSKU(arrayint));
                modifPed.add(actPedidos);

                String keyWs = TiendaCifrado.encriptaLlaveWsTienda(String.valueOf(solicitud.getNoTienda()), p.getTiendaIP(), String.valueOf(solicitud.getEmpleado()), "1");
                ap.setKeyWs(f.createReciveDatosKeyWs(keyWs));
                ap.setTipoUsuario(3);
                ap.setTipoSistema(1);
                ap.setTipoNegocio(3);
                ModifPed arrayPedidos = new ModifPed();
                arrayPedidos.setActPedidos(modifPed);
                ap.setModifPed(f.createModifPed(arrayPedidos));
                actPedido.setDatosP(f.createActualizaPedidoDatosP(ap));
                ClassLoader classloader = Thread.currentThread().getContextClassLoader();
                URL wsdlLocation = classloader.getResource("Elektra.Servicios.Datos.AdmonUniformes.wsdl");
                WSUniformes wsTienda = new WSUniformes(wsdlLocation, new QName("http://tempuri.org/", "WSUniformes"));
                IWSUniformes port = wsTienda.getPort(IWSUniformes.class);
                /*Handler para obtener peticion y respuesta ws soap*/
                BindingProvider prov = (BindingProvider) port;
                prov.getRequestContext().put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, "http://"+p.getTiendaIP()+"/WebServicioTienda/Elektra.Servicios.Datos.AdmonUniformes.WSUniformes.svc");
                List<Handler> handlers = prov.getBinding().getHandlerChain();
                SoapPeticionRespuestaHandler spr = new SoapPeticionRespuestaHandler();
                handlers.add(spr);
                prov.getBinding().setHandlerChain(handlers);
                ActualizaPedidoResponse re = port.actualizaPedido(actPedido);
                SalidaDatos respAct = re.getActualizaPedidoResult().getValue();
                p.setDatosProceso(this.formatPeticionRespuesta(spr.getPeticion(), spr.getRespuesta()));
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

    private String formatPeticionRespuesta(String peticion, String respuesta) {
        StringBuilder petResp = new StringBuilder();
        petResp.append("----peticion-----\n");
        petResp.append(peticion);
        petResp.append("----respuesta-----\n");
        petResp.append(respuesta);
        return petResp.toString();
    }
}
