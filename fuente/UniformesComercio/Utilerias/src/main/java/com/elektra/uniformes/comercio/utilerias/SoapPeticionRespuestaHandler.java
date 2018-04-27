/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.utilerias;

import Com.Elektra.Log.Dao.LogeoDAO;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Set;
import javax.xml.namespace.QName;
import javax.xml.ws.handler.soap.SOAPMessageContext;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;
import javax.xml.ws.handler.MessageContext;
import javax.xml.ws.handler.soap.SOAPHandler;

/**
 *
 * @author kortizl
 */
public class SoapPeticionRespuestaHandler implements SOAPHandler<SOAPMessageContext> {

    private String peticion = null;
    private String respuesta = null;

    @Override
    public Set<QName> getHeaders() {
        return null;
    }

    @Override
    public boolean handleMessage(SOAPMessageContext c) {
        this.procesaPeticionRespuesta(c);
        return true;
    }

    @Override
    public boolean handleFault(SOAPMessageContext c) {
        this.procesaPeticionRespuesta(c);
        return true;
    }

    @Override
    public void close(MessageContext mc) {
    }

    private void procesaPeticionRespuesta(SOAPMessageContext sc) {
        Boolean esRequest = (Boolean) sc.get(MessageContext.MESSAGE_OUTBOUND_PROPERTY);
        SOAPMessage soapMessage = sc.getMessage();
        try {
            ByteArrayOutputStream bAOS = new ByteArrayOutputStream();
            soapMessage.writeTo(bAOS);
            String strSoap = new String(bAOS.toByteArray());
            if (esRequest) {
                setPeticion(strSoap);
            } else {
                setRespuesta(strSoap);
            }
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion(e.getMessage());
        }
    }

    /**
     * @return the peticion
     */
    public String getPeticion() {
        return peticion;
    }

    /**
     * @param peticion the peticion to set
     */
    public void setPeticion(String peticion) {
        this.peticion = peticion;
    }

    /**
     * @return the respuesta
     */
    public String getRespuesta() {
        return respuesta;
    }

    /**
     * @param respuesta the respuesta to set
     */
    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }
}
