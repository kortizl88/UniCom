/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO.LlaveMaestaWS;

import java.net.URL;
import javax.xml.namespace.QName;

/**
 *
 * @author kortizl
 */
public class ClienteLlaveMaestra {

    public static String url = "";

    public static String validaLlaveMaestraEmpleado(String peticion) throws Exception {
        String resp = ""; 
        try {
            ObjectFactory f = new ObjectFactory();
            ValidaSesion validaSesion = new ValidaSesion(new URL(url), new QName("http://tempuri.org/", "Valida_sesion"));
            ValidaSesionSoap validaSesionSoap = validaSesion.getValidaSesionSoap();
            resp = validaSesionSoap.recibePeticion(peticion);
        } catch (Exception ex) {
            throw ex;
        }
        return resp;
    }
}
