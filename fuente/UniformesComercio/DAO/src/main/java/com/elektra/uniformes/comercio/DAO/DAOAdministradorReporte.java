/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.mapper.Mapper;
import com.elektra.uniformes.comercio.Modelo.BitacoraSolicitud;
import com.elektra.uniformes.comercio.Modelo.CargaSemestral;
import com.elektra.uniformes.comercio.Modelo.EstatusSolicitud;
import com.elektra.uniformes.comercio.Modelo.ReporteDTO;
import com.elektra.uniformes.comercio.Modelo.ReporteReq;
import com.elektra.uniformes.comercio.Modelo.Tienda;
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

/**
 *
 * @author kortizl
 */
@Component("daoAdministradorReporte")
public class DAOAdministradorReporte {

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

    public ArrayList<EstatusSolicitud> getEstatus() throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        Mapper m = new Mapper();
        ArrayList<EstatusSolicitud> lc = null;
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_ESTATUS_SOLICITUD);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            lc = (ArrayList<EstatusSolicitud>) m.mapperArrayBean(rs, EstatusSolicitud.class);
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getCargas " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getCargas " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return lc;
    }

    public ArrayList<Tienda> getTiendas() throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        Mapper m = new Mapper();
        ArrayList<Tienda> lc = null;
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_TIENDAS);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            lc = (ArrayList<Tienda>) m.mapperArrayBean(rs, Tienda.class);
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getTiendas " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getTiendas " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return lc;
    }

    public ArrayList<ReporteDTO> obtieneReporte(ReporteReq reporteReq) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        Mapper m = new Mapper();
        ArrayList<ReporteDTO> lc = null;
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_REPORTE);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, reporteReq.getIndicaFecha());
            cs.setString(3, reporteReq.getFechaInicio());
            cs.setString(4, reporteReq.getFechaFin());
            cs.setInt(5, reporteReq.getIndCarga());
            cs.setString(6, reporteReq.getCarga());
            cs.setInt(7, reporteReq.getIndEstatus());
            cs.setString(8, reporteReq.getEstatus());
            cs.setInt(9, reporteReq.getIndTienda());
            cs.setInt(10, reporteReq.getTienda());
            cs.setInt(11, reporteReq.getIndEmpleado());
            cs.setInt(12, reporteReq.getEmpleado());
            cs.setInt(13, reporteReq.getIndSol());
            cs.setInt(14, reporteReq.getSolicitud());
            cs.setInt(15, reporteReq.getIndRem());
            cs.setInt(16, reporteReq.getRemision());
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            lc = (ArrayList<ReporteDTO>) m.mapperArrayBean(rs, ReporteDTO.class);
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getTiendas " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getTiendas " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return lc;
    }

    public ArrayList<BitacoraSolicitud> getSeguimientoSolicitud(int solicitud, int datosProc) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        Mapper m = new Mapper();
        ArrayList<BitacoraSolicitud> lc = null;
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_SEGUIMIENTO_SOL);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, solicitud);
            cs.setInt(3, datosProc);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            lc = (ArrayList<BitacoraSolicitud>) m.mapperArrayBean(rs, BitacoraSolicitud.class);
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getSeguimientoSolicitud " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getSeguimientoSolicitud " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return lc;
    }
}
