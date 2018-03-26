/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.mapper.Mapper;
import com.elektra.uniformes.comercio.Modelo.Administrador;
import com.elektra.uniformes.comercio.Modelo.Avance;
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
@Component("daoAdministrador")
public class DAOAdministrador {

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

    public Administrador getDatosAdministrador(int numEmpleado) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        Mapper m = new Mapper();
        Administrador ad = null;
        try {
            conn = fabricaDAO.getConexion();
            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            /*cs = conn.prepareCall(funcionesBD.FN_CONS_INFOEMPLEADO);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, numEmpleado);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            ad = m.mapperBean(rs, Administrador.class);*/
            ad = new Administrador();
            ad.setNombre("Kristian Ortiz");
            ad.setNumeroEmpledo(888198);
            ad.setArea("SISTEMAS");
        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getAvance " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getSolicitudes " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return ad;
    }
}
