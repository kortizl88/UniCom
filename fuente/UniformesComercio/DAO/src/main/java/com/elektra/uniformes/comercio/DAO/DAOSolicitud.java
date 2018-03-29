/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.mapper.Mapper;
import com.elektra.uniformes.comercio.Modelo.DetalleSolicitud;
import com.elektra.uniformes.comercio.Modelo.EmpleadoKitDTO;
import com.elektra.uniformes.comercio.Modelo.RespuestaSolicitudDTO;
import com.elektra.uniformes.comercio.Modelo.SolicitudDTO;
import com.elektra.uniformes.comercio.Modelo.Tienda;
import com.elektra.uniformes.comercio.utilerias.FuncionesBD;
import com.elektra.uniformes.comercio.Modelo.Usuario;
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
@Component("daoSolicitud")
public class DAOSolicitud {

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
    
        public Tienda getInfoTienda(int pais, int canal, int tienda) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        Tienda t = new Tienda();
        ResultSet rs = null;
        Mapper m = new Mapper();
        try {
            conn = fabricaDAO.getConexion();

            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_INFO_TIENDA);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, pais);
            cs.setInt(3, canal);
            cs.setInt(4, tienda);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            t = (Tienda)m.mapperBean(rs, Tienda.class);

        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getInfoTienda " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getInfoTienda " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return t;
    }
        
    public ArrayList<EmpleadoKitDTO> getKitEmpleado(int numEmp, int tipoSolicitud) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ArrayList<EmpleadoKitDTO> lk = new ArrayList<EmpleadoKitDTO>();
        ResultSet rs = null;
        Mapper m = new Mapper();
        try {
            conn = fabricaDAO.getConexion();

            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_KIT_EMPLEADO);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, numEmp);
            cs.setInt(3, tipoSolicitud);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            lk = (ArrayList<EmpleadoKitDTO>) m.mapperArrayBean(rs, EmpleadoKitDTO.class);

        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getKitEmpleado " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception(e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return lk;
    }

    public ArrayList<EmpleadoKitDTO> getKitEmpleadosTienda(int pais, int canal, int tienda, int tipoSolicitud) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ArrayList<EmpleadoKitDTO> lK = new ArrayList<EmpleadoKitDTO>();
        ResultSet rs = null;
        Mapper m = new Mapper();
        try {
            conn = fabricaDAO.getConexion();

            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_KIT_EMPLEADOS_TIENDA);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, pais);
            cs.setInt(3, canal);
            cs.setInt(4, tienda);
            cs.setInt(5, tipoSolicitud);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            lK = (ArrayList<EmpleadoKitDTO>) m.mapperArrayBean(rs, EmpleadoKitDTO.class);

        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getKitEmpleadosTienda " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getKitEmpleadosTienda " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return lK;
    }

    public ArrayList<Tienda> getTiendasCercanas(int pais, int canal, int tienda) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ArrayList<Tienda> lt = new ArrayList<Tienda>();
        ResultSet rs = null;
        Mapper m = new Mapper();
        try {
            conn = fabricaDAO.getConexion();

            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_TIENDAS_CERCANAS);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, pais);
            cs.setInt(3, canal);
            cs.setInt(4, tienda);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            lt = (ArrayList<Tienda>) m.mapperArrayBean(rs, Tienda.class);

        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getTiendasCercanas " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getTiendasCercanas " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return lt;
    }

    public ArrayList<RespuestaSolicitudDTO> guardaSolicitud(ArrayList<SolicitudDTO> solicitudes) throws Exception {
        ArrayList<RespuestaSolicitudDTO> ls = new ArrayList<RespuestaSolicitudDTO>();
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

            StructDescriptor descPrenda = StructDescriptor.createDescriptor(funcionesBD.TYPE_PRENDA, (java.sql.Connection) oracleConnection);
            ArrayDescriptor descArrPrenda = ArrayDescriptor.createDescriptor(funcionesBD.TYPE_ARR_PRENDA, (java.sql.Connection) oracleConnection);
            StructDescriptor descSolicitud = StructDescriptor.createDescriptor(funcionesBD.TYPE_SOLICITUD, (java.sql.Connection) oracleConnection);
            ArrayDescriptor descArrSolicitud = ArrayDescriptor.createDescriptor(funcionesBD.TYPE_ARR_SOLICITUD, (java.sql.Connection) oracleConnection);

            ArrayList<STRUCT> arEstSolicitudes = new ArrayList<STRUCT>();
            for (SolicitudDTO solicitud : solicitudes) {
                ArrayList<STRUCT> arEstDetalle = new ArrayList<STRUCT>();
                for (DetalleSolicitud detalle : solicitud.getDetalle()) {
                    Object[] detO = new Object[7];
                    detO[0] = detalle.getPais();
                    detO[1] = detalle.getCanal();
                    detO[2] = detalle.getSucursal();
                    detO[3] = detalle.getIdTipoPrenda();
                    detO[4] = detalle.getIdTalla();
                    detO[5] = detalle.getCantidad();
                    detO[6] = detalle.getPrecioUnitario();
                    STRUCT strPrenda = new STRUCT(descPrenda, (java.sql.Connection) oracleConnection, detO);
                    arEstDetalle.add(strPrenda);
                }
                STRUCT arD[] = arEstDetalle.toArray(new STRUCT[arEstDetalle.size()]);
                ARRAY arDet = new ARRAY(descArrPrenda, (java.sql.Connection) oracleConnection, arD);
                Object[] solO = new Object[6];
                solO[0] = solicitud.getNumEmp();
                solO[1] = solicitud.getTipo();
                solO[2] = solicitud.getNegocio();
                solO[3] = solicitud.getFuncion();
                solO[4] = solicitud.getNumEmpCaptura();
                solO[5] = arDet;
                STRUCT strSolicitud = new STRUCT(descSolicitud, (java.sql.Connection) oracleConnection, solO);
                arEstSolicitudes.add(strSolicitud);
            }

            STRUCT arF[] = arEstSolicitudes.toArray(new STRUCT[arEstSolicitudes.size()]);
            ARRAY arFinal = new ARRAY(descArrSolicitud, (java.sql.Connection) oracleConnection, arF);

            cs = conn.prepareCall(funcionesBD.SP_GUARDA_SOLICITUD);
            cs.setArray(1, arFinal);
            cs.registerOutParameter(2, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(2);
            ls = (ArrayList<RespuestaSolicitudDTO>) m.mapperArrayBean(rs, RespuestaSolicitudDTO.class);
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: guardaSolicitud " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: guardaSolicitud " + e.getMessage());
        } finally {
            close(conn, cs, null);
        }
        return ls;
    }
    
        public ArrayList<Usuario> getNuevosIngreso(int tienda) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ArrayList<Usuario> lt = new ArrayList<Usuario>();
        ResultSet rs = null;
        Mapper m = new Mapper();
        try {
            conn = fabricaDAO.getConexion();

            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_EMP_NUEVO_INGRESO);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, tienda);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            lt = (ArrayList<Usuario>) m.mapperArrayBean(rs, Usuario.class);

        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getNuevosIngreso " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getNuevosIngreso " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return lt;
    }
}
