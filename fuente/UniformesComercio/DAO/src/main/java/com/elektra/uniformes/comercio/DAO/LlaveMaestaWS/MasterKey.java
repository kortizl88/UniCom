/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO.LlaveMaestaWS;

import Com.Elektra.Log.Dao.LogeoDAO;
import gs.DSI.util.UtilCryptoGS;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import sun.misc.BASE64Decoder;

/**
 *
 * @author kortizl
 */
@Component("masterKey")
public class MasterKey {

    @Value("#{propiedadesUniformesComercio['URL_LLAVE_MTRA']}")
    public String URL_LLAVE_MTRA;
    @Value("#{propiedadesUniformesComercio['DIGITO_VER']}")
    public String DIGITO_VER;
    @Value("#{propiedadesUniformesComercio['ID_APP']}")
    public String ID_APP;
    @Value("#{propiedadesUniformesComercio['IP_SERVER']}")
    public String IP_SERVER;
    @Value("#{propiedadesUniformesComercio['VALIDAR']}")
    public String VALIDAR;

    public boolean validarLlaveEmpleado(String emp, String llave) throws Exception {
        UtilCryptoGS u = new UtilCryptoGS();
        boolean valido = false;
        if (VALIDAR.equals("SI")) {
            BASE64Decoder decoder = new BASE64Decoder();
            byte[] cipheredBytes = decoder.decodeBuffer(DIGITO_VER);
            String encKey = new String(cipheredBytes);
            String bodyPeticion = u.encriptar(emp, encKey) + ";" + u.encriptar(String.valueOf(llave), encKey) + ";" + ID_APP + ";" + u.encriptar(String.valueOf(IP_SERVER), encKey);
            ClienteLlaveMaestra.url = URL_LLAVE_MTRA + "?wsdl";
            String respuestaLlave = ClienteLlaveMaestra.validaLlaveMaestraEmpleado(bodyPeticion);
            LogeoDAO.getInstancia().logExcepcion("RESPUESTA : " + respuestaLlave);
            if (respuestaLlave.contains("Estatus=\"OK\"")) {/*validado correctamente*/
                valido = true;
            } else {/*ocurrio un error al validar*/
                throw new Exception("Por favor verifiqué su número de empleado y llave maestra");
            }

        } else {
            valido = true;
        }
        return valido;
    }

    private String getValorTag(String tag, String cadenaXML) {
        Pattern pattern = Pattern.compile("<" + tag + ">(.+?)</" + tag + ">");
        Matcher matcher = pattern.matcher(cadenaXML);
        matcher.find();
        return matcher.group(1);
    }

    private String getValorRespuestaLlave(String clave, String respuesta) {
        Pattern pattern = Pattern.compile(clave + "=\"(.+?)\"");
        Matcher matcher = pattern.matcher(respuesta);
        matcher.find();
        return matcher.group(1);
    }
}
