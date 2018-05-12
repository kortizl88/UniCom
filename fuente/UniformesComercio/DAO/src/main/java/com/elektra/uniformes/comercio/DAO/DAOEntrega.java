/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.mapper.Mapper;
import com.elektra.uniformes.comercio.Modelo.ConfirmacionEntrega;
import com.elektra.uniformes.comercio.Modelo.DetalleEntrega;
import com.elektra.uniformes.comercio.Modelo.EntregaDTO;
import com.elektra.uniformes.comercio.utilerias.FuncionesBD;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import oracle.sql.CLOB;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("daoEntrega")
public class DAOEntrega {

    @Autowired
    @Qualifier("funcionesBD")
    private FuncionesBD funcionesBD;
    @Autowired
    @Qualifier("fabricaDAO")
    private FabricaDAO fabricaDAO;
    @Autowired
    @Qualifier("daoEntregaTienda")
    private DAOEntregaTienda daoEntregaTienda;

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

    public ArrayList<EntregaDTO> getPendientesEntrega(int numEmp) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ArrayList<EntregaDTO> le = new ArrayList<EntregaDTO>();
        ResultSet rs = null;
        Mapper m = new Mapper();
        try {
            conn = fabricaDAO.getConexion();

            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_PENDIENTES_ENTREGA);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, numEmp);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            le = (ArrayList<EntregaDTO>) m.mapperArrayBean(rs, EntregaDTO.class);

        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getPendientesEntrega " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getPendientesEntrega " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return le;
    }

    public void postConfirmacionEntrega(EntregaDTO entrega) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        Mapper m = new Mapper();
        OracleConnection oracleConnection = null;
        try {
            daoEntregaTienda.descargaPedidoTienda(entrega);

            conn = fabricaDAO.getConexion();

            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            if (conn.isWrapperFor(OracleConnection.class)) {
                oracleConnection = conn.unwrap(OracleConnection.class);
            } else {
                oracleConnection = (OracleConnection) conn;
            }

            StructDescriptor sdConfirmacionEntrega = StructDescriptor.createDescriptor(funcionesBD.TYPE_CONFIRMACION_ENTREGA, (java.sql.Connection) oracleConnection);
            ArrayDescriptor adConfirmacionEntrega = ArrayDescriptor.createDescriptor(funcionesBD.TYPE_ARR_CONFIRMACION_ENTREGA, (java.sql.Connection) oracleConnection);

            ArrayList<STRUCT> listaStruct = new ArrayList<STRUCT>();
            for (DetalleEntrega pedido : entrega.getPedidos()) {
                Object[] objetoConfirmacion = new Object[13];
                objetoConfirmacion[0] = pedido.getSolicitud();
                objetoConfirmacion[1] = pedido.getNoIdDetalle();
                objetoConfirmacion[2] = pedido.getNoPais();
                objetoConfirmacion[3] = pedido.getNoCanal();
                objetoConfirmacion[4] = pedido.getNoSucursal();
                objetoConfirmacion[5] = pedido.getPedido();
                objetoConfirmacion[6] = pedido.getSku();
                objetoConfirmacion[7] = 0;
                Clob clob = oracleConnection.createClob();
                clob.setString(1,pedido.getDatosProceso());
                objetoConfirmacion[8] = clob;
                objetoConfirmacion[9] = 6;/* Estatus recibido en tienda */
                objetoConfirmacion[10] = (pedido.isErrorEntrega() ? 6 : 7);/* 6 - en tda | 7 - entregado */
                objetoConfirmacion[11] = (pedido.isErrorEntrega() ? 1 : 0);
                objetoConfirmacion[12] = pedido.getMensaje();
                STRUCT struct = new STRUCT(sdConfirmacionEntrega, (java.sql.Connection) oracleConnection, objetoConfirmacion);
                listaStruct.add(struct);
            }
            STRUCT arregloStructConfirmacion[] = listaStruct.toArray(new STRUCT[listaStruct.size()]);

            ARRAY arrayConfirmacionEntrega = new ARRAY(adConfirmacionEntrega, (java.sql.Connection) oracleConnection, arregloStructConfirmacion);

            cs = conn.prepareCall(funcionesBD.SP_GUARDA_CONFIRMACION_ENTREGA);
            cs.setArray(1, arrayConfirmacionEntrega);
            cs.registerOutParameter(2, OracleTypes.NUMBER);
            cs.execute();

            LogeoDAO.getInstancia().logExcepcion("SOLICITUD entregada al empleado - > "+ entrega.getEmpleado() +" Numero de registros actualizados en bd -> " + (int) cs.getInt(2) );
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: postConfirmacionEntrega " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: postConfirmacionEntrega " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
    }
}
