import { Component } from '@angular/core';
import { MdDialog, MdDialogRef } from '@angular/material';

//Servicios global
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';
import { AdministracionService } from '../administracion-uniforme-service';


@Component({
    selector: 'app-admin-cargas',
    templateUrl: './administracion-cargas-component.html'
})

export class AdministracionCargasComponent{

    public dialogGeneral: DialogGeneralComponent;
    public cargasAct:any[];
    public cargasAnt:any[];

    constructor(private datosUsuarioUniformesGlobalService: DatosUsuarioUniformesGlobalService, public dialog: MdDialog, public administracionService: AdministracionService){
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.consultaCargas();
    }

    public consultaCargas(){
        let dialEsp = this.dialogGeneral.iniciarEspera();
        this.administracionService.getCargas().subscribe(
            respuestaCargas => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestaCargas.error) {
                    this.cargasAct = respuestaCargas.respuesta;
                } else {
                    this.dialogGeneral.mensajeError(respuestaCargas.mensaje, "", 1);
                }
            }, error => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                console.log(error);
            }
        );
    }
}