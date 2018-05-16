/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOSolicitudTracking;
import com.elektra.uniformes.comercio.Modelo.Solicitud;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 *
 */
@Component("negocioSolicitudTracking")
public class NegocioSolicitudTracking {

    @Autowired
    @Qualifier("daoSolicitudTracking")
    private DAOSolicitudTracking daoSolicitudTracking;
    @Value("#{propiedadesUniformesComercio['HORA_CANCELACION']}")
    public String HORA_CANCELACION;
    @Value("#{propiedadesUniformesComercio['MINUTO_CANCELACION']}")
    public String MINUTO_CANCELACION;

    public ArrayList<Solicitud> getSolicitudes(Integer numeroEmpleado, Integer numeroSolicitudes) throws Exception {
        ArrayList<Solicitud> solicitudes = daoSolicitudTracking.getSolicitudes(numeroEmpleado, numeroSolicitudes);
        this.validaCancelable(solicitudes);
        return solicitudes;
    }

    private void validaCancelable(ArrayList<Solicitud> solicitudes) throws ParseException {
        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        Calendar csol = Calendar.getInstance();
        csol.set(Calendar.HOUR_OF_DAY, Integer.valueOf(HORA_CANCELACION));
        csol.set(Calendar.MINUTE, Integer.valueOf(MINUTO_CANCELACION));
        Date fechaLimiteCancelacion = csol.getTime();
        for (Solicitud sol : solicitudes) {
            Date fechaSolicitud = df.parse(sol.getCadenafechaCaptura());
            long diffInMillies = Math.abs(fechaLimiteCancelacion.getTime() - fechaSolicitud.getTime());
            long difHoras = TimeUnit.HOURS.convert(diffInMillies, TimeUnit.MILLISECONDS);
            
            if(difHoras > 24){
                sol.setCancelable(false);
            }
            if(difHoras <= 24 && sol.getCancelado() == 0 ){
                sol.setCancelable(true);
            }
        }
    }
}
