/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOSolicitud;
import com.elektra.uniformes.comercio.Modelo.EmpleadoKitDTO;
import com.elektra.uniformes.comercio.Modelo.RespuestaGuardaSolicitud;
import com.elektra.uniformes.comercio.Modelo.RespuestaSolicitudDTO;
import com.elektra.uniformes.comercio.Modelo.SolicitudDTO;
import com.elektra.uniformes.comercio.Modelo.Tienda;
import com.elektra.uniformes.comercio.Modelo.Usuario;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("negocioSolicitud")
public class NegocioSolicitud {

    @Autowired
    @Qualifier("daoSolicitud")
    private DAOSolicitud daoSolicitud;
    @Value("#{propiedadesUniformesComercio['HORA_CANCELACION']}")
    public String HORA_CANCELACION;
    @Value("#{propiedadesUniformesComercio['MINUTO_CANCELACION']}")
    public String MINUTO_CANCELACION;

    public ArrayList<EmpleadoKitDTO> getKitEmpleado(int numEmp, int tipoSolicitud) throws Exception {
        ArrayList<EmpleadoKitDTO> lk = daoSolicitud.getKitEmpleado(numEmp, tipoSolicitud);
        if (lk == null || lk.isEmpty()) {
            if (tipoSolicitud == 2 || tipoSolicitud == 3) {/*sol voluntaria - nvo ingreso*/
                throw new Exception("Aún no han transcurrido 8 semanas desde tu última solicitud");
            } else {
                throw new Exception("Ya se tiene registrada tu solicitud para la carga semestral");
            }
        }
        return lk;
    }

    public ArrayList<EmpleadoKitDTO> getKitEmpleadosTienda(int pais, int canal, int tienda, int tipoSolicitud) throws Exception {
        ArrayList<EmpleadoKitDTO> lk = daoSolicitud.getKitEmpleadosTienda(pais, canal, tienda, tipoSolicitud);
        if (lk == null || lk.isEmpty()) {
            throw new Exception("No se encontraron solicitudes pendientes para esta carga semestral en tu tienda");
        }
        return lk;
    }

    public RespuestaGuardaSolicitud guardaSolicitud(SolicitudDTO[] solicitud) throws Exception {
        ArrayList<SolicitudDTO> solicitudA = new ArrayList<SolicitudDTO>(Arrays.asList(solicitud));
        RespuestaGuardaSolicitud respSol = new RespuestaGuardaSolicitud();
        respSol.setFechaCancela(this.getFechaCancelacion());
        respSol.setSolicitudes(daoSolicitud.guardaSolicitud(solicitudA));
        return respSol;
    }

    public Tienda getInfoTienda(int pais, int canal, int tienda) throws Exception {
        return daoSolicitud.getInfoTienda(pais, canal, tienda);
    }

    public ArrayList<Tienda> getTiendasCercanas(int pais, int canal, int tienda) throws Exception {
        return daoSolicitud.getTiendasCercanas(pais, canal, tienda);
    }

    public ArrayList<Usuario> getNuevosIngreso(int pais, int canal, int ceco) throws Exception {
        return daoSolicitud.getNuevosIngreso(pais, canal, ceco);
    }

    public String cancelaSolicitud(int solicitud) throws Exception {
        return daoSolicitud.cancelaSolicitud(solicitud);
    }

    private String getFechaCancelacion() {
        String fechaCancelacion = "";
        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy ' a las '  HH:mm 'horas (Centro de México)' ");
        Date actual = new Date();

        Calendar csol = Calendar.getInstance();
        csol.set(Calendar.HOUR_OF_DAY, Integer.valueOf(HORA_CANCELACION));
        csol.set(Calendar.MINUTE, Integer.valueOf(MINUTO_CANCELACION));
        Date solicitud = csol.getTime();
        
        if(actual.before(solicitud)){
            fechaCancelacion = df.format(solicitud);
        }else{
            csol.add(Calendar.DATE, 1);
            fechaCancelacion = df.format(csol.getTime());
        }
        System.out.println("actual : " + df.format(actual) + " fecha cancela : " + df.format(solicitud));
        return fechaCancelacion;
    }
;
}
