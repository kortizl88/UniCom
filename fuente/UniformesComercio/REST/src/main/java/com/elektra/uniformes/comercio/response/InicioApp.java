/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.response;
import Com.Elektra.Log.Dao.LogeoDAO;
import com.elektra.uniformes.comercio.DAO.FabricaDAO;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 *
 * @author kortizl
 */
public class InicioApp implements ServletContextListener {
                
    @Autowired
    @Qualifier("fabricaDAO")
    private FabricaDAO fabricaDAO;
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            LogeoDAO.getInstancia().logExcepcion("INICIANDO APP...");
            WebApplicationContextUtils
                .getRequiredWebApplicationContext(sce.getServletContext())
                .getAutowireCapableBeanFactory()
                .autowireBean(this);                  
            ServletContext app = sce.getServletContext();            
            app.setAttribute("ENDPOINTWS", fabricaDAO.getCadenaEndPointWS().trim());            
        } catch (Exception ex) {
            LogeoDAO.getInstancia().logExcepcion(this.getClass().getName() + " Se presento una excepcion al iniciar el proceso: " + ex.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        LogeoDAO.getInstancia().logExcepcion("Se ha destruido el contexto");
    }    


}