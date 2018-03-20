import { Injectable } from '@angular/core';

@Injectable()
export class WSUniformesComercioGlobalService {

    private _cadenaUrl:string;

    constructor() {
	this._cadenaUrl = "";
    }
	
    public setCadenaUrl(cadena:string):void{
        this._cadenaUrl = cadena;
    }

    public getCadenaUrl():string{		
        if(this._cadenaUrl == "<%=cadenaEndpointWS%>"){
            this._cadenaUrl = 'http://localhost:8080/WebUniformesComercio';		
	}
	return this._cadenaUrl;
    }
			
    /**************************************************************************** 
    *	EntregaService
    *****************************************************************************/
	
    //Pendiente para entregar
    public urlGetPendientesEntrega(numeroEmpleado:number):string{
	return `${this._cadenaUrl}/json/entrega/pendientes/${numeroEmpleado}`;		
    }
	
    //Envia confirmacion de la entrega
    public urlPostEntregaUniformes():string{
	return `${this._cadenaUrl}/json/entrega/`;
    }
	
    /**************************************************************************** 
    *	EstatusService
    *****************************************************************************/
	
    //Consulta solicitudes del empleado
    public urlGetConsultaSolicitudes(numeroEmpleado:number):string{
	return `${this._cadenaUrl}/json/solicitudes/${numeroEmpleado}`;
    }
	
    //Consulta solicitudes del empleado
    public urlGetTracking(numeroEmpleado:number,idFolioSolicitud:number):string{
	return `${this._cadenaUrl}/json/solicitudes/${numeroEmpleado}/tracking/${idFolioSolicitud}`;
    }	
	
    //Consulta avance
    public urlGetAvance(numeroEmpleado:number,idFolioSolicitud:number):string{
	return `${this._cadenaUrl}/json/solicitudes/${numeroEmpleado}/tracking/${idFolioSolicitud}/avance`;
    }

    /**************************************************************************** 
    *	SolicitudService
    *****************************************************************************/
	
    // Consulta informacion de la tienda
    public urlGetInfoTienda(pais:number, canal:string, tienda:number):string{
	return `${this._cadenaUrl}/json/solicitud/tienda/pais/${pais}/canal/${canal}/sucursal/${tienda}`;
    }

    // Consulta informacion de las tiendas cercanas
    public urlGetTiendasCercanas(pais:number, canal:string, tienda:number):string{
        return `${this._cadenaUrl}/json/solicitud/tiendascercanas/pais/${pais}/canal/${canal}/sucursal/${tienda}`;
    }
	
    // Consulta a los empleados de nuevo ingreso
    public urlGetEmpleadosNuevoIngreso(numeroTienda:number):string{
	return `${this._cadenaUrl}/json/solicitud/nuevoingreso/sucursal/${numeroTienda}`
    }
	
    // Consulta del kit del empleado
    public urlGetKitEmpleado(numeroEmpleado:number, tipo:number):string{
	return `${this._cadenaUrl}/json/solicitud/kit/empleado/${numeroEmpleado}/tiposolicitud/${tipo}`;
    }
	
    // Consulta el kit de los empleados en tienda
    public urlGetKitEmpleadosTienda(pais:number, canal:number, tienda:number , tipo:number):string{
        return `${this._cadenaUrl}/json/solicitud/kit/pais/${pais}/canal/${canal}/sucursal/${tienda}/tiposolicitud/${tipo}`;
    }
	
    // Guarda la solicitud
    public urlGuardaSolicitud():string{
	return `${this._cadenaUrl}/json/solicitud/`;
    }
	
    /**************************************************************************** 
    *	UniformeDescuentosService
    *****************************************************************************/
	
    // Consulta solicitudes voluntarias
    public urlGetConsultaSolicitudesVoluntarias(numeroEmpleado:number):string{
	return `${this._cadenaUrl}/json/solicitudes_voluntarias/${numeroEmpleado}`;
    }
	
    // Consulta pedidos de descuentos
    public urlGetPedidosDescuentos(numeroEmpleado:number,idFolioSolicitud:number){
        return `${this._cadenaUrl}/json/solicitudes_voluntarias/${numeroEmpleado}/pedidos_descuentos/${idFolioSolicitud}`;
    }
	
    // Consulta informacion de pedidos de descuentos
    public urlGetInformacionPedidoDescuentos(numeroEmpleado:number,idFolioSolicitud:number,idNumeroPedido:number){
        return `${this._cadenaUrl}/json/solicitudes_voluntarias/${numeroEmpleado}/pedidos_descuentos/${idFolioSolicitud}/informacion/${idNumeroPedido}`;
    }
	
}
