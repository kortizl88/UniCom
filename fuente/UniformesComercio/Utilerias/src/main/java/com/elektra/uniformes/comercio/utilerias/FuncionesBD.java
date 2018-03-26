/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.utilerias;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("funcionesBD")
public class FuncionesBD {
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_INFO_TIENDA']}")
    public String FN_CONS_INFO_TIENDA;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_INFO_USUARIO']}")
    public String FN_CONS_INFO_USUARIO;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_MENU_USUARIO']}")
    public String FN_CONS_MENU_USUARIO;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_KIT_EMPLEADO']}")
    public String FN_CONS_KIT_EMPLEADO;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_KIT_EMPLEADOS_TIENDA']}")
    public String FN_CONS_KIT_EMPLEADOS_TIENDA;
    
    @Value("#{propiedadesUniformesComercio['TYPE_PRENDA']}")
    public String TYPE_PRENDA;
    
    @Value("#{propiedadesUniformesComercio['TYPE_ARR_PRENDA']}")
    public String TYPE_ARR_PRENDA;
    
    @Value("#{propiedadesUniformesComercio['TYPE_SOLICITUD']}")
    public String TYPE_SOLICITUD;
    
    @Value("#{propiedadesUniformesComercio['TYPE_ARR_SOLICITUD']}")
    public String TYPE_ARR_SOLICITUD;
    
    @Value("#{propiedadesUniformesComercio['SP_GUARDA_SOLICITUD']}")
    public String SP_GUARDA_SOLICITUD;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_TIENDAS_CERCANAS']}")
    public String FN_CONS_TIENDAS_CERCANAS;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_EMP_NUEVO_INGRESO']}")
    public String FN_CONS_EMP_NUEVO_INGRESO;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_SOLICITUDES']}")
    public String FN_CONS_SOLICITUDES;  
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_SOLICITUD']}")
    public String FN_CONS_SOLICITUD;    
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_AVANCE']}")
    public String FN_CONS_AVANCE;  
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_SOLICITUDES_VOLUNTARIAS']}")
    public String FN_CONS_SOLICITUDES_VOLUNTARIAS;  
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_PEDIDOS_PRECIO']}")
    public String FN_CONS_PEDIDOS_PRECIO;  
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_INFORMACION_PEDIDO_DESCUENTO']}")
    public String FN_CONS_INFORMACION_PEDIDO_DESCUENTO;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_MENU_FUNCION_NEGOCIO']}")
    public String FN_CONS_MENU_FUNCION_NEGOCIO;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_PENDIENTES_ENTREGA']}")
    public String FN_CONS_PENDIENTES_ENTREGA;
    
    @Value("#{propiedadesUniformesComercio['SP_GUARDA_CONFIRMACION_ENTREGA']}")
    public String SP_GUARDA_CONFIRMACION_ENTREGA; 
    
    @Value("#{propiedadesUniformesComercio['TYPE_ARR_CONFIRMACION_ENTREGA']}")
    public String TYPE_ARR_CONFIRMACION_ENTREGA;   
    
    @Value("#{propiedadesUniformesComercio['TYPE_CONFIRMACION_ENTREGA']}")
    public String TYPE_CONFIRMACION_ENTREGA;
    
    /*administrador*/
    @Value("#{propiedadesUniformesComercio['FN_CONS_INFOEMPLEADO']}")
    public String FN_CONS_INFOEMPLEADO;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_CARGA_SEMESTRAL']}")
    public String FN_CONS_CARGA_SEMESTRAL;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_TIENDAS']}")
    public String FN_CONS_TIENDAS;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_NEGOCIOS']}")
    public String FN_CONS_NEGOCIOS;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_ESTATUS_SOLICITUD']}")
    public String FN_CONS_ESTATUS_SOLICITUD;
    
    @Value("#{propiedadesUniformesComercio['FN_CONS_REPORTE']}")
    public String FN_CONS_REPORTE;
    
    @Value("#{propiedadesUniformesComercio['TYP_NEGOCIO']}")
    public String TYP_NEGOCIO;
    
    @Value("#{propiedadesUniformesComercio['TYP_ARR_NEGOCIO']}")
    public String TYP_ARR_NEGOCIO;
    
    @Value("#{propiedadesUniformesComercio['TYP_CARGA']}")
    public String TYP_CARGA;
    
    @Value("#{propiedadesUniformesComercio['SP_ACTUALIZA_CARGA']}")
    public String SP_ACTUALIZA_CARGA;
}
