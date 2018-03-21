/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.utilerias;
import Com.Elektra.Log.Dao.LogeoDAO;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 *
 * @author kortizl
 */
public class TiendaCifrado {
    
     private static final String IPADDRESS_PATTERN =
            "^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\." +
                    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\." +
                    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\." +
                    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";

    public static String encriptaLlaveWsTienda(String noTienda,
                                               String ipTienda, String emplid, String uniTotal) {

        if (!validaIpTienda(ipTienda)) {
            throw new RuntimeException("La ip de la tienda " + noTienda + " no es valida.");
        }
        String[] s = null;
        String cadena = "UNI";
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, 0);
        DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String fecha = null;
        fecha = dateFormat.format(cal.getTime());
        s = ipTienda.split("\\.");
        cadena += complicCad(noTienda, 4) + complicCad(emplid, 6)
                + complicCad(uniTotal, 2) + "-RHSISCOMUNES-" + fecha
                + "-" + complicCad(s[0], 3) + complicCad(s[1], 3)
                + complicCad(s[2], 3) + complicCad(s[3], 3);

        try {
            cadena = encriptMd5(cadena);
        } catch (NoSuchAlgorithmException e) {
            LogeoDAO.getInstancia().logExcepcion("Error al encriptar la cadena MD5" + e.getMessage());
        }

        return cadena;
    }

    private static String complicCad(String cad, int idx) {
        String str = "";
        for (int i = cad.trim().length(); i < idx; i++) {
            str += "0";
        }
        str += cad.trim();
        return str;
    }

    private static String encriptMd5(String cadena)
            throws NoSuchAlgorithmException {
        String strEncript = "";
        MessageDigest mdEnc = null;
        mdEnc = MessageDigest.getInstance("MD5");
        mdEnc.update(cadena.getBytes(), 0, cadena.length());
        strEncript = String.format("%032x",
                new BigInteger(1, mdEnc.digest()));
        return strEncript;
    }

    private static boolean validaIpTienda(final String ip) {
        Pattern pattern = Pattern.compile(IPADDRESS_PATTERN);
        Matcher matcher = pattern.matcher(ip);
        return matcher.matches();
    }
    
}
