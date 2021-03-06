/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.mapper.Mapper;
import com.elektra.uniformes.comercio.Modelo.SolicitudVoluntaria;
import com.elektra.uniformes.comercio.utilerias.FuncionesBD;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import oracle.jdbc.OracleTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("daoSolicitudVoluntaria")
public class DAOSolicitudVoluntaria {

    @Autowired
    @Qualifier("funcionesBD")
    private FuncionesBD funcionesBD;
    @Autowired
    @Qualifier("fabricaDAO")
    private FabricaDAO fabricaDAO;

    /*CERRAR LA CONEXION*/
    private void close(Connection conn, CallableStatement cs, ResultSet rs) throws SQLException {

        if (cs != null) {
            cs.close();
            cs = null;
        }
        if (conn != null) {
            conn.close();
            conn = null;
        }
        if (rs != null) {
            rs.close();
            rs = null;
        }

    }

    public ArrayList<SolicitudVoluntaria> getSolicitudesVoluntarias(Integer numeroEmpleado, Integer numeroSolicitudes) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        Mapper m = new Mapper();
        ArrayList<SolicitudVoluntaria> solicitudesVoluntarias;
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_SOLICITUDES_VOLUNTARIAS);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, numeroEmpleado);
            cs.setInt(3, numeroSolicitudes);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            solicitudesVoluntarias = null;
            solicitudesVoluntarias = (ArrayList<SolicitudVoluntaria>) m.mapperArrayBean(rs, SolicitudVoluntaria.class);

        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getSolicitudesVoluntarias " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getSolicitudesVoluntarias " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return solicitudesVoluntarias;
    }
}
