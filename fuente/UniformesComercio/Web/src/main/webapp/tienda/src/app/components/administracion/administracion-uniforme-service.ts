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
    public getDatosEmpleado(empleado: any): Observable<WrapperRespuesta> {
        let observable: Observable<WrapperRespuesta>;
        let headers = new Headers({ 'Content-Type': 'application/json' });
        let options = new RequestOptions({ headers: headers });
        try {
            observable = this.http.post(this.endPointWSUniformesComercio.consultaDatosEmpleado(), empleado, options)
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

    /*negocios*/
    public getNegocios(): Observable<WrapperRespuesta> {
        let observable: Observable<WrapperRespuesta>;
        try {
            observable = this.http.get(this.endPointWSUniformesComercio.consultaNegocios())
                .map((response: Response) => <WrapperRespuesta>response.json());
        } catch (e) {
            console.log('Ocurrio un error (AdministracionService: getNegocios) :' + e.name + ': ' + e.message);
        }
        return observable;
    }

    /* actualiza guarda carga*/
    public actualizaCarga(carga: any): Observable<WrapperRespuesta> {
        let observable: Observable<WrapperRespuesta>;
        let headers = new Headers({ 'Content-Type': 'application/json' });
        let options = new RequestOptions({ headers: headers });
        try {
            observable = this.http.post(this.endPointWSUniformesComercio.actualizaCarga(), carga, options)
                .map((response: Response) => <WrapperRespuesta>response.json());
        } catch (e) {
            console.log('Ocurrio un error (SolicitudService: guardaSolicitud) :' + e.name + ': ' + e.message);
        }
        return observable;
    }

    /* OBTIENE REPORTE */
    public obtieneReporte(postRep: any): Observable<WrapperRespuesta> {
        let observable: Observable<WrapperRespuesta>;
        let headers = new Headers({ 'Content-Type': 'application/json' });
        let options = new RequestOptions({ headers: headers });
        try {
            observable = this.http.post(this.endPointWSUniformesComercio.obtieneReporte(), postRep, options)
                .map((response: Response) => <WrapperRespuesta>response.json());
        } catch (e) {
            console.log('Ocurrio un error (SolicitudService: obtieneReporte) :' + e.name + ': ' + e.message);
        }
        return observable;
    }

    /* exportar a Excel */
    public exportarAExcel(postRep: any): Observable<WrapperRespuesta> {
        let observable: Observable<WrapperRespuesta>;
        let headers = new Headers({ 'Content-Type': 'application/json' });
        let options = new RequestOptions({ headers: headers });
        try {
            observable = this.http.post(this.endPointWSUniformesComercio.exportarAExcel(), postRep, options)
                .map((response: Response) => <WrapperRespuesta>response.json());
        } catch (e) {
            console.log('Ocurrio un error (SolicitudService: exportarAExcel) :' + e.name + ': ' + e.message);
        }
        return observable;
    }

    /*Bitacora de solicitud*/
    public seguimientoSolicitud(solicitud: number, detalleproc: number): Observable<WrapperRespuesta> {
        let observable: Observable<WrapperRespuesta>;
        try {
            observable = this.http.get(this.endPointWSUniformesComercio.seguimientoSolicitud(solicitud, detalleproc))
                .map((response: Response) => <WrapperRespuesta>response.json());
        } catch (e) {
            console.log('Ocurrio un error (AdministracionService: seguimientoSolicitud) :' + e.name + ': ' + e.message);
        }
        return observable;
    }


}	