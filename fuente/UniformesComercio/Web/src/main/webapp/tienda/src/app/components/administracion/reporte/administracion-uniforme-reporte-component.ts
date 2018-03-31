import { Component } from '@angular/core';

import { MdDialog, MdDialogRef } from '@angular/material';
import { DateAdapter, MD_DATE_FORMATS } from "@angular/material";
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';
import { ModalCargaSemestralComponent } from './modal-carga-semestral-component';
import { ModalDetalleSolicitudComponent } from './modal-detalle-solicitud-component';
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';
import { AdministracionService } from '../administracion-uniforme-service';
import { WSUniformesComercioGlobalService } from '../../servicio/endpoint/ws-uniformes-comercio-global-service';

import { NgxPaginationModule } from 'ngx-pagination';
import { SafeResourceUrl, DomSanitizer } from '@angular/platform-browser';
import { AppDateAdapter, APP_DATE_FORMATS } from '../../utileria/fecha/fecha_formato_adaptador'

@Component({
    selector: 'app-admin-reporte',
    templateUrl: './administracion-reporte-component.html',
    providers: [
        {
            provide: DateAdapter, useClass: AppDateAdapter
        },
        {
            provide: MD_DATE_FORMATS, useValue: APP_DATE_FORMATS
        }
    ]
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
    public mostrarResultado: boolean;
    public consTda: any;
    public reqPet: any;
    public pag: number;
    public filasPorPag: number;
    public urlExpExcel: SafeResourceUrl;
    public sol:number;
    public rem:number;

    constructor(public dialog: MdDialog, public sanitizer: DomSanitizer, private datosUsuarioUniformes: DatosUsuarioUniformesGlobalService, public administracionService: AdministracionService, public endPointWSUniformesComercio: WSUniformesComercioGlobalService) {
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.toggleFil = true;
        this.mostrarMensajeGuia = true;
        this.finicio = new Date();
        this.ffin = new Date();
        this.mostrarResultado = false;

        this.pag = 1;
        this.filasPorPag = 10;
        this.urlExpExcel = this.sanitizer.bypassSecurityTrustResourceUrl('about:blank');
        this.subs = this.datosUsuarioUniformes.cargaSeleccionada.subscribe((cargas) => {
            this.cargas = cargas;
        });
        this.endPointWSUniformesComercio.getCadenaUrl();
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
        let estatusSel = this.estatus.filter(est => est.sel);

        if ((this.finicio && this.ffin) || (this.filCarga && this.cargas && this.cargas.length > 0) || estatusSel.length > 0 || this.consTda || this.emp || this.sol || this.rem) {
            this.mensajeReporte = null;
            let reqRepo = {
                indicaFecha: 0,
                fechaInicio: "",
                fechaFin: "",
                indCarga: 0,
                carga: "",
                indEstatus: 0,
                estatus: "",
                indTienda: 0,
                tienda: 0,
                indEmpleado: 0,
                empleado: 0,
                indSol: 0,
                solicitud: 0,
                indRem: 0,
                remision : 0
            };

            if (this.finicio && this.ffin) {
                reqRepo.indicaFecha = 1;
                reqRepo.fechaInicio = this.formatFecha(this.finicio);
                reqRepo.fechaFin = this.formatFecha(this.ffin);
            }

            if (this.filCarga && this.cargas && this.cargas.length > 0) {
                reqRepo.indCarga = 1;
                reqRepo.carga = this.arraySeparaComas(this.cargas, 'idCarga');
            }

            if (estatusSel && estatusSel.length > 0) {
                reqRepo.indEstatus = 1;
                reqRepo.estatus = this.arraySeparaComas(estatusSel, 'idEstatus');
            }

            if (this.consTda) {
                reqRepo.indTienda = 1;
                reqRepo.tienda = this.consTda.sucursal;
            }

            if (this.emp) {
                reqRepo.indEmpleado = 1;
                reqRepo.empleado = this.emp;
            }

            if (this.sol) {
                reqRepo.indSol = 1;
                reqRepo.solicitud = this.sol;
            }

            if (this.rem) {
                reqRepo.indRem = 1;
                reqRepo.remision = this.rem;
            }

            this.reqPet = reqRepo;

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

    public detalleSolicitud(solicitud:any){
        let dialogDetalle: MdDialogRef<ModalDetalleSolicitudComponent> = this.dialog.open(ModalDetalleSolicitudComponent);
        dialogDetalle.componentInstance.solicitud = solicitud;
    }

    private formatFecha(d: Date): string {
        let fd = ("0" + d.getDate()).slice(-2) + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + d.getFullYear();
        return fd;
    }

    private arraySeparaComas(arr: any[], prop: string): string {
        let res = "";
        arr.forEach(element => {
            res += (element[prop] + ",");
        });
        return res;
    }

    public exportar() {
        this.urlExpExcel = this.sanitizer.bypassSecurityTrustResourceUrl(this.endPointWSUniformesComercio.exportarAExcel() + "/" + this.reqPet.indicaFecha + "/" + (this.reqPet.indicaFecha == 1 ? this.reqPet.fechaInicio.replace(/\//g, "-") : 0) + "/" + (this.reqPet.indicaFecha == 1 ? this.reqPet.fechaFin.replace(/\//g, "-") : 0) + "/" + this.reqPet.indCarga + "/" + (this.reqPet.indCarga == 1 ? this.reqPet.carga : "0") + "/" + this.reqPet.indEstatus + "/" + (this.reqPet.indEstatus == 1 ? this.reqPet.estatus : "0") + "/" + this.reqPet.indTienda + "/" + this.reqPet.tienda + "/" + this.reqPet.indEmpleado + "/" + this.reqPet.empleado);
    }

    onLoad() {
        console.log('onLoad executed');
    }
}