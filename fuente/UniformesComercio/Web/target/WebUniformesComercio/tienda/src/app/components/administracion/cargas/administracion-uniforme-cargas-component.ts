import { Component } from '@angular/core';
import { MdDialog, MdDialogRef } from '@angular/material';

//Servicios global
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';
import { AdministracionService } from '../administracion-uniforme-service';
import { ModalEditarCargaSemestralComponent } from './modal-editar-carga-semestral-component';
import { NgxPaginationModule } from 'ngx-pagination';

@Component({
    selector: 'app-admin-cargas',
    templateUrl: './administracion-cargas-component.html'
})

export class AdministracionCargasComponent {

    public dialogGeneral: DialogGeneralComponent;
    public cargasAct: any[];
    public cargasAnt: any[];
    private subs: any;
    public pag: number;
    public carga:any;

    constructor(private datosUsuarioUniformesGlobalService: DatosUsuarioUniformesGlobalService,
        public dialog: MdDialog,
        public administracionService: AdministracionService,
        private datosUsuarioUniformes: DatosUsuarioUniformesGlobalService) {
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.consultaCargas();
        this.pag = 1;
        this.subs = this.datosUsuarioUniformes.actualizaListaCargas.subscribe(() => {
            this.consultaCargas();
        });
    }

    public consultaCargas() {
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

    public validaVigencia(carga:any):string{
        let vigente = "";
        let hoy = new Date();
        hoy.setHours(0,0,0,0);
        let inicio = this.convierteStrAFecha(carga.fechaInicio);
        let fin = this.convierteStrAFecha(carga.fechaFin);
        if( hoy >= inicio && fin >= hoy ){
            vigente = "Sí";
        }else{
            vigente = "No";
        }
        return vigente;
    }

    public actualizaCarga(carga: any) {
        let dialogCarga: MdDialogRef<ModalEditarCargaSemestralComponent> = this.dialog.open(ModalEditarCargaSemestralComponent);
        if (carga) {
            let cargaComp = JSON.parse(JSON.stringify(carga));
            cargaComp.fechaInicio = this.convierteStrAFecha(carga.fechaInicio);
            cargaComp.fechaFin = this.convierteStrAFecha(carga.fechaFin);
            cargaComp.estatus = carga.estatus == 1 ? true : false;
            cargaComp.generarPedidos = carga.generarPedidos == 1 ? true : false;
            console.log(cargaComp);
            dialogCarga.componentInstance.carga = cargaComp;
        }

    }

    private convierteStrAFecha(f:string):Date{
        let parts = f.split('/');
        var dateO = new Date( parseInt(parts[2]), parseInt(parts[1]) - 1, parseInt(parts[0]));
        return dateO; 
    }
}