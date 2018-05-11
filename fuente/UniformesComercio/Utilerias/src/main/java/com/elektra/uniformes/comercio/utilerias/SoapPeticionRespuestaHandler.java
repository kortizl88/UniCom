/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.utilerias;

import Com.Elektra.Log.Dao.LogeoDAO;
import java.io.ByteArrayOutputStream;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;

import javax.xml.transform.stream.StreamResult;
import javax.xml.ws.LogicalMessage;
import javax.xml.ws.handler.LogicalHandler;
import javax.xml.ws.handler.LogicalMessageContext;
import javax.xml.ws.handler.MessageContext;


/**
 *
 * @author kortizl
 */
public class SoapPeticionRespuestaHandler implements LogicalHandler<LogicalMessageContext> {

    private String peticion = null;
    private String respuesta = null;

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

    @Override
    public boolean handleMessage(LogicalMessageContext c) {
        Boolean outboundProperty = (Boolean) c.get(MessageContext.MESSAGE_OUTBOUND_PROPERTY);
        LogicalMessage logicalMessage = c.getMessage();
        Source payload = logicalMessage.getPayload();
        //imprimir el payload
        try {
            TransformerFactory factory = TransformerFactory.newInstance();
            Transformer transformer = factory.newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            Result result = new StreamResult(out);
            transformer.transform(payload, result);
            String strSoap = new String(out.toByteArray(), "UTF-8");
            if (outboundProperty) {
                LogeoDAO.getInstancia().logExcepcion("mensaje de salida");
                this.setPeticion(strSoap);
            } else {
                LogeoDAO.getInstancia().logExcepcion("mensaje de entrada");
                this.setRespuesta(strSoap);
            }

        } catch (Exception ex) {
            LogeoDAO.getInstancia().logExcepcion("error procesando xml de payload");
        }

        return true;
    }

    @Override
    public boolean handleFault(LogicalMessageContext c) {
        return false;
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void close(MessageContext mc) {
    }
}
