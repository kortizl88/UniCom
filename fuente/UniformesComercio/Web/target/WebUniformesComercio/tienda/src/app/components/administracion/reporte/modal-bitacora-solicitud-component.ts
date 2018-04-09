import { Component } from '@angular/core';

import { MdDialog, MdDialogRef } from '@angular/material';
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';
import { AdministracionService } from '../administracion-uniforme-service';
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';

@Component({
    selector: 'modal-bitacora-solicitud',
    templateUrl: './modal-bitacora-solicitud.html'
})

export class ModalBitacoraSolicitudComponent {
    public dialogGeneral: DialogGeneralComponent;
    public solicitud:number;
    public datosProc:number;
    public bitacora:any[];
    public consDatosProc:boolean;
    
    constructor(public dialog: MdDialog, public administracionService: AdministracionService, private datosUsuarioUniformesGlobalService: DatosUsuarioUniformesGlobalService, public dialogRef: MdDialogRef<ModalBitacoraSolicitudComponent> ) {
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.datosProc = 0;
    }

    public consultaBitacora(solicitud:number) {
        let dialEsp = this.dialogGeneral.iniciarEspera();
        this.administracionService.seguimientoSolicitud(solicitud,this.datosProc).subscribe(
            respuestaBit => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestaBit.error) {
                    this.bitacora = respuestaBit.respuesta;
                } else {
                    this.dialogGeneral.mensajeError(respuestaBit.mensaje, "", 1);
                }
            }, error => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                console.log(error);
            }
        );
    }
}