
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
import { ConfirmacionEntrega } from '../../modelo/confirmacion_entrega';
import { UsuarioRecibe } from '../../modelo/usuario_recibe';


@Injectable()
export class EntregaService {

    constructor(private http: Http, public endPointWSUniformesComercio:WSUniformesComercioGlobalService) {}
    
    /*Obtiene los pendientes para entregar*/
    public getPendientesEntrega(numeroEmpleado:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>; 
        try{            
            observable = this.http.get(this.endPointWSUniformesComercio.urlGetPendientesEntrega(numeroEmpleado))
            .map((response: Response) => <WrapperRespuesta> response.json());
        }catch(e){
            console.log('Ocurrio un error (EntregaService: getPendientesEntrega) :'+ e.name + ': ' + e.message);
        }        
        return observable;
    }

    /**
     * Envia la confirmacion de la entrega
    */
    public postEntregaUniformes(entrega:UsuarioRecibe): Observable<WrapperRespuesta> { 
        let observable:Observable<WrapperRespuesta>;
        let headers = new Headers({ 'Content-Type': 'application/json' });
        let options = new RequestOptions({ headers: headers });
        try{            
            observable = this.http.post(this.endPointWSUniformesComercio.urlPostEntregaUniformes(),entrega)
            .map((response: Response) => <WrapperRespuesta> response.json());           
        }catch(e){
            console.log('Ocurrio un error (EntregaService postEntregaUniformes):'+ e.name + ': ' + e.message);
        }
        return observable;  
    }
}	
