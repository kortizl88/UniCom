import { ActivatedRoute, Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { MdDialog, MdDialogRef } from '@angular/material';

//Servicios global
import { DatosUsuarioUniformesGlobalService } from '../servicio/modelo/datos-usuario-uniformes-global-service';
import { DialogGeneralComponent } from '../servicio/componentes/dialog/dialog-general-component';
import { AdministracionService } from './administracion-uniforme-service';
@Component({
    selector: 'app-admin',
    templateUrl: './administracion-component.html'
})

export class AdministracionComponent {

    public usr: number;
    public pass: string;
    public dialogGeneral: DialogGeneralComponent;
    public empleado: any;

    constructor(private router: Router, private datosUsuarioUniformesGlobalService: DatosUsuarioUniformesGlobalService, public dialog: MdDialog, public administracionService: AdministracionService) {
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
    }

    public validaAcceso() {
        let dialEsp = this.dialogGeneral.iniciarEspera();
        let usr = {usuario : this.usr, password: this.pass};
        this.administracionService.getDatosEmpleado(usr).subscribe(
            respuestaDatosEmp => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestaDatosEmp.error) {
                    this.empleado = respuestaDatosEmp.respuesta;
                    this.datosUsuarioUniformesGlobalService.notificaLogin.emit({ valido: true, usr: this.empleado });
                    this.router.navigate(['/admin/cargas']);
                } else {
                    this.dialogGeneral.mensajeError(respuestaDatosEmp.mensaje, "", 1);
                }
            }, error => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                console.log(error);
            }
        );
    }

}