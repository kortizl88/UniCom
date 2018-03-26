import { Component } from '@angular/core';

import { MdDialog, MdDialogRef } from '@angular/material';
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';
import { ModalCargaSemestralComponent } from './modal-carga-semestral-component';
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';
import { AdministracionService } from '../administracion-uniforme-service';

@Component({
    selector: 'app-admin-reporte',
    templateUrl: './administracion-reporte-component.html'
})

export class AdministracionReporteComponent {

    public estatus: any[];
    public tiendas: any[];
    public tiendasFil: any[];
    public cargas: any[];
    public filCarga: boolean;
    public finicio: Date;
    public ffin: Date;
    private subs: any;
    public toggleFil: boolean;
    public mostrarMensajeGuia: boolean;
    public dialogGeneral: DialogGeneralComponent;
    public mensajeReporte: string;
    public tienda: any;
    public emp: number;
    public reporte: any;
    public mostrarResultado:boolean;

    constructor(public dialog: MdDialog, private datosUsuarioUniformes: DatosUsuarioUniformesGlobalService, public administracionService: AdministracionService) {
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.toggleFil = false;
        this.mostrarMensajeGuia = true;
        this.finicio = new Date();
        this.ffin = new Date();
        this.mostrarResultado = false;
        this.subs = this.datosUsuarioUniformes.cargaSeleccionada.subscribe((cargas) => {
            this.cargas = cargas;
        });
        this.getTiendas();
        this.getEstatus();
    }

    public getTiendas() {
        let dialEsp = this.dialogGeneral.iniciarEspera();
        this.administracionService.getTiendas().subscribe(
            respuestaTiendas => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestaTiendas.error) {
                    this.tiendas = respuestaTiendas.respuesta;
                } else {
                    this.dialogGeneral.mensajeError(respuestaTiendas.mensaje, "", 1);
                }
            }, error => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                console.log(error);
            }
        );
    };

    public getEstatus() {
        let dialEsp = this.dialogGeneral.iniciarEspera();
        this.administracionService.getEstatus().subscribe(
            respuestaEstatus => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestaEstatus.error) {
                    this.estatus = respuestaEstatus.respuesta;
                } else {
                    this.dialogGeneral.mensajeError(respuestaEstatus.mensaje, "", 1);
                }
            }, error => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                console.log(error);
            }
        );
    };

    public filtroTiendas(val: string) {
        if (val) {
            const filterValue = val.toLowerCase();
            this.tiendasFil = this.tiendas.filter(tienda => (tienda.nombreTienda + "-" + tienda.sucursal).toLowerCase().includes(filterValue));
            return this.tiendasFil;
        }
        return this.tiendas;
    }

    public toggleFiltros() {
        this.toggleFil = !this.toggleFil;
        this.mostrarMensajeGuia = false;
    }

    public mostrarNombreTda(tienda: any): String {
        if (tienda)
            return tienda.sucursal + " - " + tienda.nombreTienda;
    }

    public seleccionarCargaModal() {
        if (this.filCarga) {
            let dialogCargas: MdDialogRef<ModalCargaSemestralComponent> = this.dialog.open(ModalCargaSemestralComponent);
        }
    }

    public consultaReporte() {
        /*validar filtros aplicados*/
        let seleccionoEstatus = this.estatus.forEach(est => {
            if (est.sel) {
                return true;
            }
        });

        if ((this.finicio && this.ffin) || (this.filCarga && this.cargas && this.cargas.length > 0) || seleccionoEstatus || this.tienda || this.emp) {
            this.mensajeReporte = null;
            let reqRepo = {
                indicaFecha: 1, fechaInicio: "", fechaFin: "",
                indCarga: 1, carga: "", indEstatus: 1, estatus: "", indTienda: 1,
                tienda: 1, indEmpleado: 1, empleado: 0
            };
            let dialEsp = this.dialogGeneral.iniciarEspera();
            this.administracionService.obtieneReporte(reqRepo).subscribe(
                respuestaObtRepo => {
                    this.dialogGeneral.cerrarEsperaId(dialEsp);
                    if (!respuestaObtRepo.error) {
                        this.reporte = respuestaObtRepo.respuesta;
                        this.mostrarResultado = true;
                    } else {
                        this.dialogGeneral.mensajeError(respuestaObtRepo.mensaje, "", 1);
                    }
                }, error => {
                    this.dialogGeneral.cerrarEsperaId(dialEsp);
                    console.log(error);
                });
        }
        else {
            this.mensajeReporte = "Para optimizar el tiempo de generación de tu reporte, selecciona al menos un filtro";
        }
    }

}