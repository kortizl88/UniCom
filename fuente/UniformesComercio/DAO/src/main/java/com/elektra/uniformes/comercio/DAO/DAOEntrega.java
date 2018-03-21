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
@Component("daoEntrega")
public class DAOEntrega {

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
            for (DetalleEntrega p:entrega.getPedidos()) {
                p.setErrorEntrega(false);
                p.setMensaje("YA CAYO A LA BD");
            }
            /*
            for (int i = 0; i < confirmaciones.size(); i++) {
                System.out.println("FIFOLIOSOLICITUD " + confirmaciones.get(i).getNoFolioSolicitud());   
                System.out.println("FIIDDETALLE " + confirmaciones.get(i).getNoIdDetalle());
                System.out.println("FIPAIS " + confirmaciones.get(i).getNoPais());                
                System.out.println("FICANAL " + confirmaciones.get(i).getNoCanal());
                System.out.println("FIIDSUCURSAL " + confirmaciones.get(i).getNoIdSucursal());    
                System.out.println("FINUMPEDIDO " + confirmaciones.get(i).getNoNumPedido());      
                System.out.println("FISKU " + confirmaciones.get(i).getNoSKU());               
                System.out.println("FIIDTIPOEVENTO " + confirmaciones.get(i).getNoIdTipoEvento());          
                System.out.println("FXDATOS " + confirmaciones.get(i).getCadenaXmlDatos());                 
                System.out.println("FIIDESTATUSANT " + confirmaciones.get(i).getNoIdEstatusAnt());
                System.out.println("FIIDESTATUSNVO " + confirmaciones.get(i).getNoIdEstatusNvo());
                System.out.println("FDFECHAEVENTO ");               
                System.out.println("FIERROR " + confirmaciones.get(i).getNoError());
                System.out.println("FCCOMENTARIOS " + confirmaciones.get(i).getCadenaComentarios());                
            }
            
            conn = fabricaDAO.getConexion();

            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            if(conn.isWrapperFor(OracleConnection.class)){
                oracleConnection = conn.unwrap(OracleConnection.class);
            }else{
                oracleConnection = (OracleConnection) conn;
            }
            
            StructDescriptor sdConfirmacionEntrega = StructDescriptor.createDescriptor(funcionesBD.TYPE_CONFIRMACION_ENTREGA,(java.sql.Connection)oracleConnection);
            ArrayList<STRUCT> listaStruct = new ArrayList<STRUCT>();
            for(ConfirmacionEntrega confirmacion : confirmaciones){
                Object[] objetoConfirmacion = new Object[13];
                objetoConfirmacion[0] = confirmacion.getNoFolioSolicitud();   
                objetoConfirmacion[1] = confirmacion.getNoIdDetalle();
                objetoConfirmacion[2] = confirmacion.getNoPais();                
                objetoConfirmacion[3] = confirmacion.getNoCanal();
                objetoConfirmacion[4] = confirmacion.getNoIdSucursal();    
                objetoConfirmacion[5] = confirmacion.getNoNumPedido();      
                objetoConfirmacion[6] = confirmacion.getNoSKU();               
                objetoConfirmacion[7] = confirmacion.getNoIdTipoEvento();          
                objetoConfirmacion[8] = confirmacion.getCadenaXmlDatos();
                objetoConfirmacion[9] = confirmacion.getNoIdEstatusAnt();
                objetoConfirmacion[10] = confirmacion.getNoIdEstatusNvo();                           
                objetoConfirmacion[11] = confirmacion.getNoError();
                objetoConfirmacion[12] = confirmacion.getCadenaComentarios(); 
                STRUCT struct = new STRUCT(sdConfirmacionEntrega,(java.sql.Connection)oracleConnection,objetoConfirmacion);
                listaStruct.add(struct);
            }
            STRUCT arregloStructConfirmacion[] = listaStruct.toArray(new STRUCT[listaStruct.size()]);
            ArrayDescriptor adConfirmacionEntrega = ArrayDescriptor.createDescriptor(funcionesBD.TYPE_ARR_CONFIRMACION_ENTREGA,(java.sql.Connection)oracleConnection);
            ARRAY arrayConfirmacionEntrega = new ARRAY(adConfirmacionEntrega,(java.sql.Connection)oracleConnection,arregloStructConfirmacion);
                    
            cs = conn.prepareCall(funcionesBD.SP_GUARDA_CONFIRMACION_ENTREGA);
            cs.setArray(1, arrayConfirmacionEntrega);            
            cs.registerOutParameter(2,OracleTypes.NUMBER);
            cs.execute();
            
            System.out.println("Numero de registros " + (int)cs.getInt(2));
            */
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: postConfirmacionEntrega " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: postConfirmacionEntrega " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
    }
}
