import { Component } from '@angular/core';
import { OnDestroy } from '@angular/core'

//Servicio Global
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';


//Modelo
import { Usuario } from '../../modelo/usuario';
import { UsuarioRecibe } from '../../modelo/usuario_recibe';


//WS
import { EntregaService } from './entrega-uniforme-service';


//Componentes
import { MdDialog, MdDialogRef } from '@angular/material';
import { DialogDetalleEntrega } from './dialog-entrega-uniforme-component';
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';


@Component({
    selector: 'app-entrega-uniforme',
    templateUrl: './entrega-uniforme-component.html'
})

export class EntregaUniformeComponent {

    public usuarioLogueado: Usuario;
    public usuariosRecibenPendientes: UsuarioRecibe[];
    public dialogGeneral: DialogGeneralComponent;
    public empBusqueda: string;

    constructor(public datosUsuarioUniformes: DatosUsuarioUniformesGlobalService,
        public entregaService: EntregaService,
        public dialog: MdDialog) {
        this.usuarioLogueado = datosUsuarioUniformes.getDatosUsuario();
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.dialogGeneral.iniciarEspera();
        this.consultaPendientesEntrega(this.usuarioLogueado.empleado);
    }

    public consultaPendientesEntrega(empleado: number): void {
        this.entregaService.getPendientesEntrega(empleado).subscribe(
            respuestaWS => {
                this.dialogGeneral.cerrarEspera();
                if (!respuestaWS.error) {
                    this.usuariosRecibenPendientes = respuestaWS.respuesta;
                } else {
                    this.dialogGeneral.cerrarEspera();
                    this.dialogGeneral.mensajeError("Ocurrio un error al consultar las solicitudes para entregar", respuestaWS.mensaje, 1);
                }
            }, error => {
                this.dialogGeneral.cerrarEspera();
                this.dialogGeneral.mensajeError("Error independiente del WSUniformesComercio (consulta de pendientes de entrega)", error, 1);
            }
        );
    }

    public iniciaProcesoEntrega(usuarioRecibe: UsuarioRecibe, usuarioEntrega: Usuario): void {
        let dialogDetEntrega: MdDialogRef<DialogDetalleEntrega> = this.dialog.open(DialogDetalleEntrega, {disableClose: true});
        dialogDetEntrega.componentInstance.usuarioRecibe = usuarioRecibe;
        dialogDetEntrega.componentInstance.usuarioEntrega = usuarioEntrega;
    }

}

/*filtro busqueda empleado*/
import { Injectable, Pipe, PipeTransform } from '@angular/core';

@Pipe({
    name: 'searchFilter'
})

@Injectable()
export class SearchFilterPipe implements PipeTransform {

    transform(items: any[], field: string, value: string): any[] {
        if (!items) return [];
        if (value === "" || !value) return items;
        return items.filter(it => it[field] == value);
    }

}



