/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.DAO;

import org.springframework.stereotype.Component;
import javax.naming.Context;
import javax.sql.DataSource;
import java.sql.Connection;
import javax.naming.InitialContext;
import org.springframework.beans.factory.annotation.Value;

/**
 *
 * @author kortizl
 */
@Component
public class FabricaDAO {

    private Context contexto;
    private Connection conexion;
    private DataSource dataSource;
    
    @Value("#{propiedadesUniformesComercio['DATASOURCE']}")
    private String DS;
    
    @Value("#{propiedadesUniformesComercio['ENDPOINTWS']}")
    private String cadenaEndPointWS;

    public Connection getConexion() throws Exception {
        try {

            if (dataSource == null) {
                contexto = new InitialContext();
                dataSource = ((DataSource) contexto.lookup(DS));
            }
            if (dataSource != null) {
                conexion = dataSource.getConnection();

            }
        } catch (Exception ne) {
            //ConfigLogueo.logeoAbstractoDAO.logExcepcion("FabricaDAO: Ocurrio un Error en la conexion " + ne.getMessage());
            throw new Exception("FabricaDAO: Ocurrio un Error en la conexion " + ne.getMessage());
        }
        return conexion;
    }

    public void setContexto(Context contex) {
        contexto = contex;
    }

    public String getCadenaEndPointWS() {
        return cadenaEndPointWS;
    }

    public void setCadenaEndPointWS(String cadenaEndPointWS) {
        this.cadenaEndPointWS = cadenaEndPointWS;
    }

    public String getDS() {
        return DS;
    }

    public void setDS(String DS) {
        this.DS = DS;
    }
    
    
        
}