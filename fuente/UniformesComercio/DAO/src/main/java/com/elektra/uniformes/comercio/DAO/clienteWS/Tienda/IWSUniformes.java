
package com.elektra.uniformes.comercio.DAO.clienteWS.Tienda;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.xml.bind.annotation.XmlSeeAlso;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.1.6 in JDK 6
 * Generated source version: 2.1
 * 
 */
@WebService(name = "IWSUniformes", targetNamespace = "http://tempuri.org/")
@SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
@XmlSeeAlso({
    ObjectFactory.class
})
public interface IWSUniformes {


    /**
     * 
     * @param parameters
     * @return
     *     returns clienteWS.Tienda.GeneraPedidoResponse
     */
    @WebMethod(operationName = "GeneraPedido", action = "http://tempuri.org/IWSUniformes/GeneraPedido")
    @WebResult(name = "GeneraPedidoResponse", targetNamespace = "http://tempuri.org/", partName = "parameters")
    public GeneraPedidoResponse generaPedido(
        @WebParam(name = "GeneraPedido", targetNamespace = "http://tempuri.org/", partName = "parameters")
        GeneraPedido parameters);

    /**
     * 
     * @param parameters
     * @return
     *     returns clienteWS.Tienda.ActualizaPedidoResponse
     */
    @WebMethod(operationName = "ActualizaPedido", action = "http://tempuri.org/IWSUniformes/ActualizaPedido")
    @WebResult(name = "ActualizaPedidoResponse", targetNamespace = "http://tempuri.org/", partName = "parameters")
    public ActualizaPedidoResponse actualizaPedido(
        @WebParam(name = "ActualizaPedido", targetNamespace = "http://tempuri.org/", partName = "parameters")
        ActualizaPedido parameters);

    /**
     * 
     * @param parameters
     * @return
     *     returns clienteWS.Tienda.ConsultaPedidoResponse
     */
    @WebMethod(operationName = "ConsultaPedido", action = "http://tempuri.org/IWSUniformes/ConsultaPedido")
    @WebResult(name = "ConsultaPedidoResponse", targetNamespace = "http://tempuri.org/", partName = "parameters")
    public ConsultaPedidoResponse consultaPedido(
        @WebParam(name = "ConsultaPedido", targetNamespace = "http://tempuri.org/", partName = "parameters")
        ConsultaPedido parameters);

    /**
     * 
     * @param parameters
     * @return
     *     returns clienteWS.Tienda.ConsultaParametrosResponse
     */
    @WebMethod(operationName = "ConsultaParametros", action = "http://tempuri.org/IWSUniformes/ConsultaParametros")
    @WebResult(name = "ConsultaParametrosResponse", targetNamespace = "http://tempuri.org/", partName = "parameters")
    public ConsultaParametrosResponse consultaParametros(
        @WebParam(name = "ConsultaParametros", targetNamespace = "http://tempuri.org/", partName = "parameters")
        ConsultaParametros parameters);

}