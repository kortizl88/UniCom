import { Component } from '@angular/core';
//Servicios global
/*import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';


//Modelo
import { Menu } from '../../modelo/menu';
import { Usuario } from '../../modelo/usuario';*/

import { MdDialog, MdDialogRef } from '@angular/material';
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';
import { AdministracionService } from '../administracion-uniforme-service';
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';

@Component({
    selector: 'modal-carga-semestral',
    templateUrl: './modal-carga-semestral.html'
})

export class ModalCargaSemestralComponent {
    public dialogGeneral: DialogGeneralComponent;
    public cargas: any[];
    public msgError : string;

    constructor(public dialog: MdDialog, public administracionService: AdministracionService, private datosUsuarioUniformesGlobalService: DatosUsuarioUniformesGlobalService, public dialogRef: MdDialogRef<ModalCargaSemestralComponent> ) {
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.consultaCargas();
    }

    public consultaCargas() {
        let dialEsp = this.dialogGeneral.iniciarEspera();
        this.administracionService.getCargas().subscribe(
            respuestaCargas => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestaCargas.error) {
                    this.cargas = respuestaCargas.respuesta;
                } else {
                    this.dialogGeneral.mensajeError(respuestaCargas.mensaje, "", 1);
                }
            }, error => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                console.log(error);
            }
        );
    }

    public seleccionarCargasConsulta() {
        let cargasSel = [];
        this.cargas.forEach(carga => {
            if (carga.sel) {
                cargasSel.push(carga);
            }
        });
        if (cargasSel.length > 0) {
            this.datosUsuarioUniformesGlobalService.cargaSeleccionada.emit(cargasSel);
            this.dialogRef.close();
        }else{
            this.msgError = "Seleccione al menos una carga";
        }
    }

}