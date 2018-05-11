/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.mapper.Mapper;
import com.elektra.uniformes.comercio.Modelo.Administrador;
import com.elektra.uniformes.comercio.Modelo.CargaSemestral;
import com.elektra.uniformes.comercio.Modelo.CentroDistribucion;
import com.elektra.uniformes.comercio.Modelo.DetalleSolicitud;
import com.elektra.uniformes.comercio.Modelo.Negocio;
import com.elektra.uniformes.comercio.Modelo.RespuestaSolicitudDTO;
import com.elektra.uniformes.comercio.Modelo.SolicitudDTO;
import com.elektra.uniformes.comercio.utilerias.FuncionesBD;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("daoAdministradorCargas")
public class DAOAdministradorCargas {

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

    public ArrayList<CargaSemestral> getCargas() throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        Mapper m = new Mapper();
        ArrayList<CargaSemestral> lc = null;
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_CARGA_SEMESTRAL);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            lc = (ArrayList<CargaSemestral>) m.mapperArrayBean(rs, CargaSemestral.class);
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getCargas " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getCargas " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return lc;
    }

    public ArrayList<Negocio> getNegocios() throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        Mapper m = new Mapper();
        ArrayList<Negocio> ln = null;
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_NEGOCIOS);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            ln = (ArrayList<Negocio>) m.mapperArrayBean(rs, Negocio.class);
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getCargas " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getCargas " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return ln;
    }
    
    public ArrayList<CentroDistribucion> getCeDis() throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        Mapper m = new Mapper();
        ArrayList<CentroDistribucion> ln = null;
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_CEDIS);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            ln = (ArrayList<CentroDistribucion>) m.mapperArrayBean(rs, CentroDistribucion.class);
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getCeDis " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getCargas " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return ln;
    }

    public String actualizaCarga(CargaSemestral carga) throws Exception {
        String res = "";
        Connection conn = null;
        CallableStatement cs = null;
        OracleConnection oracleConnection = null;
        ResultSet rs = null;
        Mapper m = new Mapper();
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new SQLException("La conexion no se creo.");
            }
            if (conn.isWrapperFor(OracleConnection.class)) {
                oracleConnection = conn.unwrap(OracleConnection.class);
            } else {
                oracleConnection = (OracleConnection) conn;
            }

            StructDescriptor descNegocio = StructDescriptor.createDescriptor(funcionesBD.TYP_NEGOCIO, (java.sql.Connection) oracleConnection);
            ArrayDescriptor descArrNegocio = ArrayDescriptor.createDescriptor(funcionesBD.TYP_ARR_NEGOCIO, (java.sql.Connection) oracleConnection);
            StructDescriptor descCD = StructDescriptor.createDescriptor(funcionesBD.TYP_CEDIS, (java.sql.Connection) oracleConnection);
            ArrayDescriptor descArrCD = ArrayDescriptor.createDescriptor(funcionesBD.TYP_ARR_CEDIS, (java.sql.Connection) oracleConnection);
            StructDescriptor descCarga = StructDescriptor.createDescriptor(funcionesBD.TYP_CARGA, (java.sql.Connection) oracleConnection);
            
            /*negocios*/
            ArrayList<STRUCT> arNeg = new ArrayList<STRUCT>();
            for (Negocio negocio : carga.getNegocios()) {
                Object[] detO = new Object[2];
                detO[0] = negocio.getIdNegocio();
                detO[1] = negocio.getNegocio();
                STRUCT strNeg = new STRUCT(descNegocio, (java.sql.Connection) oracleConnection, detO);
                arNeg.add(strNeg);
            }
            STRUCT arF[] = arNeg.toArray(new STRUCT[arNeg.size()]);
            ARRAY arNegocios = new ARRAY(descArrNegocio, (java.sql.Connection) oracleConnection, arF);
            
            /*cedis*/
            ArrayList<STRUCT> arCD = new ArrayList<STRUCT>();
            for (CentroDistribucion cd : carga.getCedis()) {
                Object[] detO = new Object[2];
                detO[0] = cd.getPais();
                detO[1] = cd.getCedis();
                STRUCT strCD = new STRUCT(descCD, (java.sql.Connection) oracleConnection, detO);
                arCD.add(strCD);
            }
            STRUCT arC[] = arCD.toArray(new STRUCT[arCD.size()]);
            ARRAY arCedis = new ARRAY(descArrCD, (java.sql.Connection) oracleConnection, arC);
            
            Object[] cargaO = new Object[8];
            cargaO[0] = carga.getIdCarga();
            cargaO[1] = carga.getTitulo();
            cargaO[2] = carga.getFechaInicio();
            cargaO[3] = carga.getFechaFin();
            cargaO[4] = carga.getEstatus();
            cargaO[5] = carga.getGenerarPedidos();
            cargaO[6] = arNegocios;
            cargaO[7] = arCedis;

            STRUCT strCarga = new STRUCT(descCarga, (java.sql.Connection) oracleConnection, cargaO);


            cs = conn.prepareCall(funcionesBD.SP_ACTUALIZA_CARGA);
            cs.setObject(1, strCarga);
            cs.registerOutParameter(2, OracleTypes.NUMBER);
            cs.execute();
            res = "Se actualizò la carga correctamente";
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: guardaSolicitud " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: guardaSolicitud " + e.getMessage());
        } finally {
            close(conn, cs, null);
        }
        return res;
    }
}
