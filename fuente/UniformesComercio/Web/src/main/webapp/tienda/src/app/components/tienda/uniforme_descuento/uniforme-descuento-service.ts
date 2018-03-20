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
export class UniformeDescuentoService {
	
    constructor(private http: Http, public endPointWSUniformesComercio:WSUniformesComercioGlobalService) {}
	
    /**
     * Mapea los objetos json y extrae la informacion de las solicitudes voluntarias.
     */
    public getConsultaSolicitudesVoluntarias(numeroEmpleado:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>;
        try{            
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetConsultaSolicitudesVoluntarias(numeroEmpleado))
            .map((response: Response) => <WrapperRespuesta> response.json());          
        }catch(e){
            console.log('Ocurrio un error (UniformeDescuentoService: getConsultaSolicitudes):'+ e.name + ': ' + e.message);
        }
        return observable;  
    }

    /**
     * Mapea los objetos json y extrae la informacion de pedidos descuentos.
     */
    public getPedidosDescuentos(numeroEmpleado:number,idFolioSolicitud:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>;		
        try{            
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetPedidosDescuentos(numeroEmpleado,idFolioSolicitud))
            .map((response: Response) => <WrapperRespuesta> response.json());       
        }catch(e){
            console.log('Ocurrio un error (UniformeDescuentoService: getPedidosDescuentos):'+ e.name + ': ' + e.message);
        }
        return observable;  
    }

    /**
     * Mapea los objetos json y extrae la informacion de pedidos descuentos.
     */
    public getInformacionPedidoDescuentos(numeroEmpleado:number,idFolioSolicitud:number,idNumeroPedido:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>;		
        try{            
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetInformacionPedidoDescuentos(numeroEmpleado,idFolioSolicitud,idNumeroPedido))
            .map((response: Response) => <WrapperRespuesta> response.json());            
        }catch(e){
            console.log('Ocurrio un error (UniformeDescuentoService: getInformacionPedidoDescuentos):'+ e.name + ': ' + e.message);
        }
        return observable;  
    }
   
}
