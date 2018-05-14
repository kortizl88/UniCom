import { Injectable } from '@angular/core';

@Injectable()
export class WSUniformesComercioGlobalService {

    private _cadenaUrl: string;

    constructor() {
        this._cadenaUrl = "";
    }

    public setCadenaUrl(cadena: string): void {
        this._cadenaUrl = cadena;
    }

    public getCadenaUrl(): string {
        if (this._cadenaUrl == "<%=cadenaEndpointWS%>") {
            this._cadenaUrl = 'http://localhost:8080/WebUniformesComercio';
        }
        return this._cadenaUrl;
    }

    /**************************************************************************** 
    *	EntregaService
    *****************************************************************************/

    //Pendiente para entregar
    public urlGetPendientesEntrega(numeroEmpleado: number): string {
        return `${this._cadenaUrl}/json/entrega/pendientes/${numeroEmpleado}`;
    }

    //Envia confirmacion de la entrega
    public urlPostEntregaUniformes(): string {
        return `${this._cadenaUrl}/json/entrega/`;
    }

    /**************************************************************************** 
    *	EstatusService
    *****************************************************************************/

    //Consulta solicitudes del empleado
    public urlGetConsultaSolicitudes(numeroEmpleado: number): string {
        return `${this._cadenaUrl}/json/solicitudes/${numeroEmpleado}`;
    }

    //Consulta solicitudes del empleado
    public urlGetTracking(numeroEmpleado: number, idFolioSolicitud: number): string {
        return `${this._cadenaUrl}/json/solicitudes/${numeroEmpleado}/tracking/${idFolioSolicitud}`;
    }

    //Consulta avance
    public urlGetAvance(numeroEmpleado: number, idFolioSolicitud: number): string {
        return `${this._cadenaUrl}/json/solicitudes/${numeroEmpleado}/tracking/${idFolioSolicitud}/avance`;
    }

    //cancelar solicitud
    public cancelaSolicitud(solicitud:number): string {
        return `${this._cadenaUrl}/json/solicitud/cancelar/${solicitud}`;
    }

    /**************************************************************************** 
    *	SolicitudService
    *****************************************************************************/

    // Consulta informacion de la tienda
    public urlGetInfoTienda(pais: number, canal: number, tienda: number): string {
        return `${this._cadenaUrl}/json/solicitud/tienda/pais/${pais}/canal/${canal}/sucursal/${tienda}`;
    }

    // Consulta informacion de las tiendas cercanas
    public urlGetTiendasCercanas(pais: number, canal: number, tienda: number): string {
        return `${this._cadenaUrl}/json/solicitud/tiendascercanas/pais/${pais}/canal/${canal}/sucursal/${tienda}`;
    }

    // Consulta a los empleados de nuevo ingreso
    public urlGetEmpleadosNuevoIngreso(pais:number, canal: number, ceco: number): string {
        return `${this._cadenaUrl}/json/solicitud/nuevoingreso/pais/${pais}/canal/${canal}/ceco/${ceco}`
    }

    // Consulta del kit del empleado
    public urlGetKitEmpleado(numeroEmpleado: number, tipo: number): string {
        return `${this._cadenaUrl}/json/solicitud/kit/empleado/${numeroEmpleado}/tiposolicitud/${tipo}`;
    }

    // Consulta el kit de los empleados en tienda
    public urlGetKitEmpleadosTienda(pais: number, canal: number, tienda: number, tipo: number): string {
        return `${this._cadenaUrl}/json/solicitud/kit/pais/${pais}/canal/${canal}/sucursal/${tienda}/tiposolicitud/${tipo}`;
    }

    // Guarda la solicitud
    public urlGuardaSolicitud(): string {
        return `${this._cadenaUrl}/json/solicitud/`;
    }

    /**************************************************************************** 
    *	UniformeDescuentosService
    *****************************************************************************/

    // Consulta solicitudes voluntarias
    public urlGetConsultaSolicitudesVoluntarias(numeroEmpleado: number): string {
        return `${this._cadenaUrl}/json/solicitudes_voluntarias/${numeroEmpleado}`;
    }

    // Consulta pedidos de descuentos
    public urlGetPedidosDescuentos(numeroEmpleado: number, idFolioSolicitud: number) {
        return `${this._cadenaUrl}/json/solicitudes_voluntarias/${numeroEmpleado}/pedidos_descuentos/${idFolioSolicitud}`;
    }

    // Consulta informacion de pedidos de descuentos
    public urlGetInformacionPedidoDescuentos(numeroEmpleado: number, idFolioSolicitud: number, idNumeroPedido: number) {
        return `${this._cadenaUrl}/json/solicitudes_voluntarias/${numeroEmpleado}/pedidos_descuentos/${idFolioSolicitud}/informacion/${idNumeroPedido}`;
    }

    /**************************************************************************** 
    *	AdministracionService
    *****************************************************************************/
    public consultaDatosEmpleado(): string {
        return `${this._cadenaUrl}/json/administracion/datos/acceso`;
    }
    public consultaCargas(): string {
        return `${this._cadenaUrl}/json/administracion/carga`;
    }
    public actualizaCarga(): string {
        return `${this._cadenaUrl}/json/administracion/carga`;
    }
    public consultaEstatus(): string {
        return `${this._cadenaUrl}/json/administracion/reporte/estatus`;
    }
    public consultaTiendas(): string {
        return `${this._cadenaUrl}/json/administracion/reporte/tiendas`;
    }
    public consultaNegocios(): string {
        return `${this._cadenaUrl}/json/administracion/reporte/negocios`;
    }
    public consultaCeDis(): string {
        return `${this._cadenaUrl}/json/administracion/reporte/cedis`;
    }
    public obtieneReporte(): string {
        return `${this._cadenaUrl}/json/administracion/reporte`;
    }
    public exportarAExcel(): string {
        return `${this._cadenaUrl}/json/administracion/reporte/generar`;
    }

    public seguimientoSolicitud(solicitud:number, detalleproc:number): string {
        return `${this._cadenaUrl}/json/administracion/reporte/seguimiento/solicitud/${solicitud}/detalleproc/${detalleproc}`;
    }

}
