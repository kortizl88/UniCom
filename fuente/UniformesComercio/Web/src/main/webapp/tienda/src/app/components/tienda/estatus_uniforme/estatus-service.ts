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
export class EstatusService {
    
    private numeroEmpleado:number;
    private idFolioSolicitud:number;

    constructor(private http: Http, public endPointWSUniformesComercio:WSUniformesComercioGlobalService) {}
    	
    /**
     * Mapea los objetos json y extrae la informacion de las solicitudes.
     */
    public getConsultaSolicitudes(numeroEmpleado:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>;
        this.numeroEmpleado = numeroEmpleado;
        try{            
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetConsultaSolicitudes(numeroEmpleado))
            .map((response: Response) => <WrapperRespuesta> response.json());            
        }catch(e){
            console.log('Ocurrio un error (catch getConsultaSolicitudes):'+ e.name + ': ' + e.message); 
        }
        return observable;  
    }

    /**
     * Mapea los objetos json y extrae la informacion de tracking.
     */
    public getTracking(idFolioSolicitud:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>;
        this.idFolioSolicitud = idFolioSolicitud;
        try{            
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetTracking(this.numeroEmpleado,this.idFolioSolicitud))
            .map((response: Response) => <WrapperRespuesta> response.json());
        }catch(e){
            console.log('Ocurrio un error (catch getTracking):'+ e.name + ': ' + e.message);
        }
        return observable;  
    }

    /**
     * Mapea los objetos json y extrae la informacion del avance.
     */
    public getAvance(): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>;
        try{            
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetAvance(this.numeroEmpleado,this.idFolioSolicitud))
            .map((response: Response) => <WrapperRespuesta> response.json());            
        }catch(e){
            console.log('Ocurrio un error (EstatusService: getAvance):'+ e.name + ': ' + e.message);
        }
        return observable;  
   }

   public cancelaSolicitud(solicitud: number): Observable<WrapperRespuesta> {
    let observable:Observable<WrapperRespuesta>;
    try{            
        observable = this.http.get(this.endPointWSUniformesComercio.cancelaSolicitud(solicitud))
        .map((response: Response) => <WrapperRespuesta> response.json());            
    }catch(e){
        console.log('Ocurrio un error (EstatusService: cancelaSolicitud):'+ e.name + ': ' + e.message);
    }
    return observable;  
}
   
}
