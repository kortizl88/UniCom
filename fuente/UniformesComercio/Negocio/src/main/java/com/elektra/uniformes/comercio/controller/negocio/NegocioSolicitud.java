/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOSolicitud;
import com.elektra.uniformes.comercio.Modelo.EmpleadoKitDTO;
import com.elektra.uniformes.comercio.Modelo.RespuestaSolicitudDTO;
import com.elektra.uniformes.comercio.Modelo.SolicitudDTO;
import com.elektra.uniformes.comercio.Modelo.Tienda;
import com.elektra.uniformes.comercio.Modelo.Usuario;
import java.util.ArrayList;
import java.util.Arrays;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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

    public ArrayList<EmpleadoKitDTO> getKitEmpleado(int numEmp, int tipoSolicitud) throws Exception {
        return daoSolicitud.getKitEmpleado(numEmp, tipoSolicitud);
    }
    
    public ArrayList<EmpleadoKitDTO> getKitEmpleadosTienda(int pais, int canal, int tienda, int tipoSolicitud) throws Exception {
        return daoSolicitud.getKitEmpleadosTienda(pais, canal, tienda,tipoSolicitud);
    }
    
    public ArrayList<RespuestaSolicitudDTO> guardaSolicitud(SolicitudDTO[] solicitud) throws Exception {
        ArrayList<SolicitudDTO> solicitudA = new ArrayList<SolicitudDTO>(Arrays.asList(solicitud));
        return daoSolicitud.guardaSolicitud(solicitudA);
    }

    public Tienda getInfoTienda(int pais, int canal, int tienda) throws Exception{
        return daoSolicitud.getInfoTienda(pais, canal, tienda);
    }
    
    public ArrayList<Tienda> getTiendasCercanas(int pais, int canal, int tienda) throws Exception{
        return daoSolicitud.getTiendasCercanas(pais, canal, tienda);
    }
    
    public ArrayList<Usuario> getNuevosIngreso(int tienda) throws Exception {
        return daoSolicitud.getNuevosIngreso(tienda);
    }
}
