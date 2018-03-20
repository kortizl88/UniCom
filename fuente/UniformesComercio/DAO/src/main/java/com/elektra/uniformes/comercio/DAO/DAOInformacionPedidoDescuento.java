/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.DAO;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.mapper.Mapper;
import com.elektra.uniformes.comercio.Modelo.Avance;
import com.elektra.uniformes.comercio.Modelo.InformacionPedidoDescuento;
import com.elektra.uniformes.comercio.Modelo.TotalesPedidosDescuentos;
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

@Component("daoInformacionPedidoDescuento")
public class DAOInformacionPedidoDescuento {

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
                   
    public ArrayList<InformacionPedidoDescuento> getInformacionPedidoDescuento(Integer folioSolicitud, Integer numeroPedido) throws Exception {                           
        Connection conn = null;
        CallableStatement cs = null;      
        ResultSet rs = null;        
        Mapper m = new Mapper();        
        ArrayList<InformacionPedidoDescuento> listaIPD;
        Avance avance = null;
                System.out.println("ID getSolicitudes "+ folioSolicitud);
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }           
            cs = conn.prepareCall(funcionesBD.FN_CONS_INFORMACION_PEDIDO_DESCUENTO);            
            cs.registerOutParameter(1, OracleTypes.CURSOR);              
            cs.setInt(2, folioSolicitud);
            cs.setInt(3, numeroPedido);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);            

            listaIPD = null;
            
            listaIPD = (ArrayList<InformacionPedidoDescuento>) m.mapperArrayBean(rs, InformacionPedidoDescuento.class);   
                        
            double totalPagoSemanal = 0;
            
            for (int i = 0; i < listaIPD.size(); i++) {
                totalPagoSemanal += Double.parseDouble(((InformacionPedidoDescuento)listaIPD.get(i)).getCadenaPagoSemanal().substring(1));       
            }
            
            TotalesPedidosDescuentos tpd = new TotalesPedidosDescuentos();
            tpd.setCadenaTotalPagoSemanal(totalPagoSemanal);  
            
            InformacionPedidoDescuento ipd = new InformacionPedidoDescuento();                          
            ipd.setCadenaPagoSemanal(tpd.getCadenaTotalPagoSemanal()); 
            
            listaIPD.add(ipd);
            
            if (listaIPD.size() == 0) {                
                System.out.println("Esta vacia la estrutura de datos (arrayList)");
            }
                
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getInformacionPedidoDescuento " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getInformacionPedidoDescuento " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }        
        return listaIPD;
    }
    
}
