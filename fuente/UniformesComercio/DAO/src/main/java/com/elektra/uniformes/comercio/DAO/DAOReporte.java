/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import com.elektra.uniformes.comercio.Modelo.Pedido;
import com.elektra.uniformes.comercio.Modelo.DetallePedido;
import com.elektra.uniformes.comercio.utilerias.FuncionesBD;
import com.elektra.uniformes.comercio.Modelo.Reporte;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("daoReporte")
public class DAOReporte {

    @Autowired
    @Qualifier("funcionesBD")
    private FuncionesBD funcionesBD;

    public ArrayList<Reporte> getReporte() {
        ArrayList<Reporte> lr = new ArrayList<Reporte>();
        SimpleDateFormat sd = new SimpleDateFormat("dd/MM/yyyy");
        Random rnd;
        Date dt;
        long ms;

        for (int x = 0; x < 20; x++) {
            Reporte r = new Reporte();
            r.setNumEmpleado(554541);
            r.setNombre("Javier Pérez López");
            r.setFolio(String.valueOf(154245 + x));
            r.setEstatusGral("Pendiente entrega");
            r.setFuncion("Socio Vendedor");
            rnd = new Random();
            ms = -946771200000L + (Math.abs(rnd.nextLong()) % (70L * 365 * 24 * 60 * 60 * 1000));
            dt = new Date(ms);
            r.setFecha(sd.format(dt));
            rnd = new Random();
            ms = -946771200000L + (Math.abs(rnd.nextLong()) % (70L * 365 * 24 * 60 * 60 * 1000));
            dt = new Date(ms);
            rnd = new Random();
            r.setFechaPrimerRemision(sd.format(dt));
            ms = -946771200000L + (Math.abs(rnd.nextLong()) % (70L * 365 * 24 * 60 * 60 * 1000));
            dt = new Date(ms);
            r.setFechaUltimaRemision(sd.format(dt));
            lr.add(r);
        }

        return lr;
    }

    public Pedido getReportePedido(int idPedido) {
        Pedido p = new Pedido();
        SimpleDateFormat sd = new SimpleDateFormat("dd/MM/yyyy");
        Random rnd;
        Date dt;
        long ms;

        p.setFolio(idPedido);
        p.setNombreEmp("Javier Pérez López");
        p.setNumEmp(554541);
        p.setNoTienda(100);
        p.setNombreTienda("EKT LA LUNA");
        rnd = new Random();
        ms = -946771200000L + (Math.abs(rnd.nextLong()) % (70L * 365 * 24 * 60 * 60 * 1000));
        dt = new Date(ms);
        p.setFecha(sd.format(dt));
        
        ArrayList<DetallePedido> det  = new ArrayList<DetallePedido>();
        
        DetallePedido dp = new DetallePedido();
        dp.setPedidoCD(515112);
        dp.setSku(44778);
        dp.setDescripcionPrenda("CAMISA DC MANGA LARGA");
        dp.setCantidad(2);
        rnd = new Random();
        ms = -946771200000L + (Math.abs(rnd.nextLong()) % (70L * 365 * 24 * 60 * 60 * 1000));
        dt = new Date(ms);
        dp.setRemision(sd.format(dt));
        dp.setNoRemision(rnd.nextInt());
        dp.setEstatus("Entregado");
        det.add(dp);
        
        dp = new DetallePedido();
        dp.setPedidoCD(515112);
        dp.setSku(39957);
        dp.setDescripcionPrenda("CAMISA DC MANGA CORTA");
        dp.setCantidad(2);
        rnd = new Random();
        ms = -946771200000L + (Math.abs(rnd.nextLong()) % (70L * 365 * 24 * 60 * 60 * 1000));
        dt = new Date(ms);
        dp.setRemision(sd.format(dt));
        dp.setNoRemision(rnd.nextInt());
        dp.setEstatus("Entregado");
        det.add(dp);
        
        dp = new DetallePedido();
        dp.setPedidoCD(515112);
        dp.setSku(88574);
        dp.setDescripcionPrenda("PANTALON DC");
        dp.setCantidad(3);
        rnd = new Random();
        ms = -946771200000L + (Math.abs(rnd.nextLong()) % (70L * 365 * 24 * 60 * 60 * 1000));
        dt = new Date(ms);
        dp.setRemision(sd.format(dt));
        dp.setNoRemision(rnd.nextInt());
        dp.setEstatus("Entregado");
        det.add(dp);
        
        p.setDetallePedido(det);
        
        return p;
    }
}
