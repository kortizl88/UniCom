/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.DAO;
import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.mapper.Mapper;
import com.elektra.uniformes.comercio.Modelo.PedidoDescuento;
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

@Component("daoPedidoDescuento")
public class DAOPedidoDescuento{

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
                   

    public ArrayList<PedidoDescuento> getPedidosDescuentos(Integer numeroFolioSolicitud) throws Exception {                           
        Connection conn = null;
        CallableStatement cs = null;
        ResultSet rs = null;        
        Mapper m = new Mapper();        
        ArrayList<PedidoDescuento> listaObjetos;
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }           
            cs = conn.prepareCall(funcionesBD.FN_CONS_PEDIDOS_PRECIO);            
            cs.registerOutParameter(1, OracleTypes.CURSOR);  
            cs.setInt(2, numeroFolioSolicitud);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);      
            listaObjetos = null;            
            listaObjetos = (ArrayList<PedidoDescuento>) m.mapperArrayBean(rs, PedidoDescuento.class); 

            double totalPagado = 0;
            double totalSaldoPorPagar = 0;
            double totalCostoPrenda = 0;
            for (int i = 0; i < listaObjetos.size(); i++) {
                totalPagado += Double.parseDouble(((PedidoDescuento)listaObjetos.get(i)).getCadenaPagado().substring(1));
                totalSaldoPorPagar += Double.parseDouble(((PedidoDescuento)listaObjetos.get(i)).getCadenaSaldoPorPagar().substring(1));
                totalCostoPrenda += Double.parseDouble(((PedidoDescuento)listaObjetos.get(i)).getCadenaCostoPrenda().substring(1));                
            }
            
            TotalesPedidosDescuentos tpd = new TotalesPedidosDescuentos();
            tpd.setCadenaTotalPagado(totalPagado);
            tpd.setCadenaTotalSaldoPorPagar(totalSaldoPorPagar);
            tpd.setCadenaTotalCostoPrenda(totalCostoPrenda);  
            
            PedidoDescuento pd = new PedidoDescuento();            
            pd.setCadenaPagado(tpd.getCadenaTotalPagado());        
            pd.setCadenaCostoPrenda(tpd.getCadenaTotalCostoPrenda());
            pd.setCadenaSaldoPorPagar(tpd.getCadenaTotalSaldoPorPagar());                     
            listaObjetos.add(pd);
            
            if (listaObjetos.size() == 0) {
                System.out.println("Esta vacia la estrutura de datos (arrayList)");
            }            
                
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getPedidosDescuentos " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getPedidosDescuentos " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }        
        return listaObjetos;
    }
    
}
