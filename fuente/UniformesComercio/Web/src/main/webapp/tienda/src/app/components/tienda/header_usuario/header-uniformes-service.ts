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
export class UsuarioService {

    constructor(private http: Http, public endPointWSUniformesComercio:WSUniformesComercioGlobalService) {}
        
    /*obtiene los datos del empleado*/
    public getDatosUsuario(numEmp:number, tienda:number): Observable<WrapperRespuesta> {        
        let observable:Observable<WrapperRespuesta>;
        try{
            observable = this.http.get(`${this.endPointWSUniformesComercio.getCadenaUrl()}/json/usuario/${numEmp}/tienda/${tienda}`)
            .map((response: Response) => <WrapperRespuesta> response.json());
        }catch(e){
            console.log('Ocurrio un error (UsuarioService: getDatosUsuario) :'+ e.name + ': ' + e.message);
        }        
        return observable;
    }

    /*obtiene el menu asignado al empleado*/
    public getMenuFuncionNegocio(numEmp:number, noFuncion:number, noNegocio:number): Observable<WrapperRespuesta> {
        let observable:Observable<WrapperRespuesta>;
        try{
            observable = this.http.get(`${this.endPointWSUniformesComercio.getCadenaUrl()}/json/usuario/${numEmp}/funcion/${noFuncion}/negocio/${noNegocio}`)
            .map((response: Response) => <WrapperRespuesta> response.json());
        }catch(e){
            console.log('Ocurrio un error (UsuarioService: getMenuFuncionNegocio) :'+ e.name + ': ' + e.message);
        }        
        return observable;
    }
   
}