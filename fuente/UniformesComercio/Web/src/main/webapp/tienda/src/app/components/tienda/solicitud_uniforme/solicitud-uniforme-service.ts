import { Http, Headers, Response, Jsonp, RequestOptions } from '@angular/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/toPromise';
import 'rxjs/add/operator/catch';

//Servicio Global
import { WSUniformesComercioGlobalService } from '../../servicio/endpoint/ws-uniformes-comercio-global-service';


//Modelo
import { WrapperRespuesta } from '../../modelo/wrapper_respuesta';


@Injectable()
export class SolicitudService {

    constructor(private http: Http, public endPointWSUniformesComercio:WSUniformesComercioGlobalService) {}
    
    /*Obtiene la info de la tienda*/
    public getInfoTienda(pais:number, canal:string, tienda:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>; 
        try{
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetInfoTienda(pais,canal,tienda))
            .map((response: Response) => <WrapperRespuesta> response.json());
        }catch(e){
            console.log('Ocurrio un error (SolicitudService: getInfoTienda) :'+ e.name + ': ' + e.message);
        }        
        return observable;
    }
	
    /*Obtiene las tiendas cercanas*/
    public getTiendasCercanas(pais:number, canal:string, tienda:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>; 
        try{
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetTiendasCercanas(pais,canal,tienda))
            .map((response: Response) => <WrapperRespuesta> response.json());
        }catch(e){
            console.log('Ocurrio un error (SolicitudService: getTiendasCercanas) :'+ e.name + ': ' + e.message);
        }        
        return observable;
    }
	
    /*Obtiene los empleados de nuevo ingreso*/
    public getEmpleadosNuevoIngreso(numeroTienda:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>;
        try{
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetEmpleadosNuevoIngreso(numeroTienda))
            .map((response: Response) => <WrapperRespuesta> response.json());
        }catch(e){
            console.log('Ocurrio un error (SolicitudService: getEmpleadosNuevoIngreso) :'+ e.name + ': ' + e.message);
        }        
        return observable;
    }
	
	
    /*Obtiene el kit del empleado*/
    public getKitEmpleado(numeroEmpleado:number, tipo:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>;
        try{
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetKitEmpleado(numeroEmpleado,tipo))
            .map((response: Response) => <WrapperRespuesta> response.json());
        }catch(e){
            console.log('Ocurrio un error (SolicitudService: getKitEmpleado) :'+ e.name + ': ' + e.message);
        }        
        return observable;
    }
	
    /*Obtiene los empleados y kits correspondientes*/
    public getKitEmpleadosTienda(pais:number, canal:number, tienda:number , tipo:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>; 
        try{
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetKitEmpleadosTienda(pais,canal,tienda,tipo))
            .map((response: Response) => <WrapperRespuesta> response.json());
        }catch(e){
            console.log('Ocurrio un error (SolicitudService: getDatosUsuario) :'+ e.name + ': ' + e.message);
        }        
        return observable;
    }
	
	/*guardar solicitud*/
    public guardaSolicitud(solicitud:any): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>; 
		let headers = new Headers({ 'Content-Type': 'application/json' });
		let options = new RequestOptions({ headers: headers });
        try{
            observable = this.http.post(this.endPointWSUniformesComercio.urlGuardaSolicitud(),solicitud,options)
            .map((response: Response) => <WrapperRespuesta> response.json());
        }catch(e){
            console.log('Ocurrio un error (SolicitudService: guardaSolicitud) :'+ e.name + ': ' + e.message);
        }        
        return observable;
    }	
   
}