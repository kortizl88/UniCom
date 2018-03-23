import { Http, Headers, Response, Jsonp, RequestOptions } from '@angular/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/toPromise';
import 'rxjs/add/operator/catch';

//Servicio Global
import { WSUniformesComercioGlobalService } from '../servicio/endpoint/ws-uniformes-comercio-global-service';

//Modelo
import { WrapperRespuesta } from '../modelo/wrapper_respuesta';

@Injectable()
export class AdministracionService {

    constructor(private http: Http, public endPointWSUniformesComercio: WSUniformesComercioGlobalService) {
        this.endPointWSUniformesComercio.getCadenaUrl();
    }
    /*TODO: SERVICIO LOGIN */

    /*datos empleado logueado*/
    public getDatosEmpleado(numeroEmpleado: number): Observable<WrapperRespuesta> {
        let observable: Observable<WrapperRespuesta>;
        try {
            observable = this.http.get(this.endPointWSUniformesComercio.consultaDatosEmpleado(numeroEmpleado))
                .map((response: Response) => <WrapperRespuesta>response.json());
        } catch (e) {
            console.log('Ocurrio un error (AdministracionService: getDatosEmpleado) :' + e.name + ': ' + e.message);
        }
        return observable;
    }

    /*cargas*/
    public getCargas(): Observable<WrapperRespuesta> {
        let observable: Observable<WrapperRespuesta>;
        try {
            observable = this.http.get(this.endPointWSUniformesComercio.consultaCargas())
                .map((response: Response) => <WrapperRespuesta>response.json());
        } catch (e) {
            console.log('Ocurrio un error (AdministracionService: getCargas) :' + e.name + ': ' + e.message);
        }
        return observable;
    }

    /*Estatus*/
    public getEstatus(): Observable<WrapperRespuesta> {
        let observable: Observable<WrapperRespuesta>;
        try {
            observable = this.http.get(this.endPointWSUniformesComercio.consultaEstatus())
                .map((response: Response) => <WrapperRespuesta>response.json());
        } catch (e) {
            console.log('Ocurrio un error (AdministracionService: getEstatus) :' + e.name + ': ' + e.message);
        }
        return observable;
    }

    /*tiendas*/
    public getTiendas(): Observable<WrapperRespuesta> {
        let observable: Observable<WrapperRespuesta>;
        try {
            observable = this.http.get(this.endPointWSUniformesComercio.consultaTiendas())
                .map((response: Response) => <WrapperRespuesta>response.json());
        } catch (e) {
            console.log('Ocurrio un error (AdministracionService: getTiendas) :' + e.name + ': ' + e.message);
        }
        return observable;
    }

}	