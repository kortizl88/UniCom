import { Component, OnInit } from '@angular/core';
import { MdDialog, MdDialogRef } from '@angular/material';
import { EstatusService } from './estatus-service';

// Servicio global Dialog
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';


//Modelo
import { Usuario } from '../../modelo/usuario';
import { Solicitud } from '../../modelo/solicitud';
import { Tracking } from '../../modelo/tracking';
import { Avance } from '../../modelo/avance';
import { WrapperRespuesta } from '../../modelo/wrapper_respuesta';


//Componentes
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';


@Component({
    selector: 'app-estatus-uniforme',
    templateUrl: './estatus-uniforme-component.html'
})

export class EstatusUniformeComponent {

    private dialogGeneral: DialogGeneralComponent;
    private estatusService: EstatusService;
    public solicitudes: Solicitud[];
    public solicitud: Solicitud;
    private _trackings: Tracking[];
    private _avance: Avance;

    constructor(public dialog: MdDialog, estatusService: EstatusService, public datosUsuarioUniformes: DatosUsuarioUniformesGlobalService) {
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.estatusService = estatusService;
        this.consultarSolicitudes();
    }

    public seleccionaFolioSolicitud(): void {
        this.consultarTracking(this.solicitud.nofolioSolicitud);
    }

    /**
     * Consumo del servicio web endpoint : 
     */
    private consultarSolicitudes(): void {
        let esp = this.dialogGeneral.iniciarEspera();
        this.estatusService.getConsultaSolicitudes(this.datosUsuarioUniformes.getDatosUsuario().empleado).subscribe(
            respuestaWS => {
                this.dialogGeneral.cerrarEsperaId(esp);
                if (this.contieneSolicitudes(respuestaWS)) {
                    this.solicitudes = respuestaWS.respuesta;
                    this.solicitud = this.solicitudes[0];
                    this.seleccionaFolioSolicitud();
                }
            }, error => {
                this.dialogGeneral.cerrarEsperaId(esp);
                this.dialogGeneral.mensajeError("Ocurrio un problema al consumir los WS getConsultaSolicitudes", error, 1);
            }
        );
    }

    /**
     * Consumo del servicio web endpoint : 
     */
    private consultarTracking(idFolioSolicitud: number): void {
        let esp = this.dialogGeneral.iniciarEspera();
        this.estatusService.getTracking(idFolioSolicitud).subscribe(
            respuestaWS => {
                this._trackings = respuestaWS.respuesta;
                this.dialogGeneral.cerrarEsperaId(esp);
                this.consultarAvance();
            }, error => {
                this.dialogGeneral.cerrarEsperaId(esp);
                this.dialogGeneral.mensajeError("Ocurrio un problema al consumir los WS getTracking", error, 1);
            }
        );
    }

    /**
     * Consumo del servicio web endpoint : 
     */
    private consultarAvance(): void {
        let esp = this.dialogGeneral.iniciarEspera();
        this.estatusService.getAvance().subscribe(
            respuestaWS => {
                this._avance = respuestaWS.respuesta;
                this.dialogGeneral.cerrarEsperaId(esp);
            }, error => {
                this.dialogGeneral.cerrarEsperaId(esp);
                this.dialogGeneral.mensajeError("Ocurrio un problema al consumir los WS getAvance", error, 1);
            }
        );
    }

    /**
     * Valida si hay se muestra un error en la parte WS, ademas si tiene solicitudes
     */
    private contieneSolicitudes(respuestaWS: WrapperRespuesta): boolean {
        if (!respuestaWS.error) {
            if (respuestaWS.respuesta.length == 0) {
                //this.dialogGeneral.mensajeError('No tiene que consultar', '', 2);
                return false;
            } else {
                return true;
            }
        } else {
            this.dialogGeneral.mensajeError('Ocurrio un problema en la parte WS', '', 1);
            return false;
        }
    }

    get trackings() {
        return this._trackings;
    }

    get avance() {
        return this._avance;
    }

}