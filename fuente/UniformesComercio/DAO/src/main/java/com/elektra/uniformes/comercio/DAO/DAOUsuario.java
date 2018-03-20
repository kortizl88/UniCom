/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.mapper.Mapper;
import com.elektra.uniformes.comercio.Modelo.Menu;
import com.elektra.uniformes.comercio.utilerias.FuncionesBD;
import com.elektra.uniformes.comercio.Modelo.Usuario;
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
@Component("daoUsuario")
public class DAOUsuario {

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

    public Usuario getInformacionUsuario(int numEmp) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        Usuario u = new Usuario();
        ResultSet rs = null;
        Mapper m = new Mapper();
        try {
            conn = fabricaDAO.getConexion();

            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_INFO_USUARIO);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, numEmp);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            u = (Usuario) m.mapperBean(rs, Usuario.class);

        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getInformacionUsuario " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getInformacionUsuario " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return u;
    }

    public ArrayList<Menu> getMenuUsuario(int numEmp) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ArrayList<Menu> lU = new ArrayList<Menu>();
        ResultSet rs = null;
        Mapper m = new Mapper();
        try {
            conn = fabricaDAO.getConexion();

            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_MENU_USUARIO);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, numEmp);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            lU = (ArrayList<Menu>) m.mapperArrayBean(rs, Menu.class);

        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getMenuUsuario " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getMenuUsuario " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return lU;
    }
    
    public ArrayList<Menu> getMenuFuncionNegocio(int noFuncionSap, int noNegocio) throws Exception {
        Connection conn = null;
        CallableStatement cs = null;
        ArrayList<Menu> lU = new ArrayList<Menu>();
        ResultSet rs = null;
        Mapper m = new Mapper();
        try {
            conn = fabricaDAO.getConexion();

            if (conn == null) {
                throw new Exception("La conexion no se creo.");
            }
            cs = conn.prepareCall(funcionesBD.FN_CONS_MENU_FUNCION_NEGOCIO);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setInt(2, noNegocio);
            cs.setInt(3, noFuncionSap);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            lU = (ArrayList<Menu>) m.mapperArrayBean(rs, Menu.class);

        } catch (Exception e) {
            LogeoDAO.getInstancia().logExcepcion("ERROR en : " + this.getClass() + " metodo: getMenuFuncionNegocio " + e.getMessage());
            LogeoDAO.getInstancia().logStackExcepcion(e);
            throw new Exception("ERROR en : " + this.getClass() + " metodo: getMenuFuncionNegocio " + e.getMessage());
        } finally {
            close(conn, cs, rs);
        }
        return lU;
    }
}
