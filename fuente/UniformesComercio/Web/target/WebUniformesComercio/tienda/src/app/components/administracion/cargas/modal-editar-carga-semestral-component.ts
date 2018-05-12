import { Component } from '@angular/core';

import { MdDialog, MdDialogRef } from '@angular/material';
import { DateAdapter, MD_DATE_FORMATS } from "@angular/material";
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';
import { AdministracionService } from '../administracion-uniforme-service';
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';

import { AppDateAdapter, APP_DATE_FORMATS } from '../../utileria/fecha/fecha_formato_adaptador'

@Component({
    selector: 'modal-editar-carga-semestral',
    templateUrl: './modal-editar-carga-semestral.html',
    providers: [
        {
            provide: DateAdapter, useClass: AppDateAdapter
        },
        {
            provide: MD_DATE_FORMATS, useValue: APP_DATE_FORMATS
        }
    ]
})

export class ModalEditarCargaSemestralComponent {
    public dialogGeneral: DialogGeneralComponent;
    public carga: any;
    public negocios: any[];
    public cedis: any[];
    public msgError: string;
    public errNegocios: boolean;
    public errFecha: boolean;
    public msjFecha: string;

    constructor(public dialog: MdDialog, public administracionService: AdministracionService, private datosUsuarioUniformesGlobalService: DatosUsuarioUniformesGlobalService, public dialogRef: MdDialogRef<ModalEditarCargaSemestralComponent>) {
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.carga = { idCarga: 0, titulo: null, estatus: 1, generarPedidos: 0 };
        this.consultaNegocios();
        this.consultaCeDis();
    }

    public consultaNegocios() {
        let dialEsp = this.dialogGeneral.iniciarEspera();
        this.administracionService.getNegocios().subscribe(
            respuestaNegocios => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestaNegocios.error) {
                    this.negocios = respuestaNegocios.respuesta;
                    if (this.carga.negocios) {
                        this.negocios.forEach(n => {
                            this.carga.negocios.forEach(ns => {
                                if (ns.idNegocio == n.idNegocio) {
                                    n.seleccionado = true;
                                }
                            });
                        });
                    }

                } else {
                    this.dialogGeneral.mensajeError(respuestaNegocios.mensaje, "", 1);
                }
            }, error => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                console.log(error);
            }
        );
    }

    public consultaCeDis() {
        let dialEsp = this.dialogGeneral.iniciarEspera();
        this.administracionService.getCeDis().subscribe(
            respuestaCD => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestaCD.error) {
                    this.cedis = respuestaCD.respuesta;
                    if (this.carga.cedis) {
                        this.cedis.forEach(n => {
                            this.carga.cedis.forEach(ns => {
                                if (ns.cedis == n.cedis) {
                                    n.seleccionado = true;
                                }
                            });
                        });
                    }

                } else {
                    this.dialogGeneral.mensajeError(respuestaCD.mensaje, "", 1);
                }
            }, error => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                console.log(error);
            }
        );
    }

    public actualizaCarga() {
        this.errNegocios = false;
        this.errFecha = false;
        let nSel = this.negocios.filter(n => n.seleccionado);
        let cdSel = this.cedis.filter(CD => CD.seleccionado);
        if( !this.carga.titulo || this.carga.titulo == "" )
        {
            console.log("error ti")
        }else if (!this.carga.fechaInicio || !this.carga.fechaFin) {
            this.errFecha = true;
            this.msjFecha = "Seleccione las fechas para la vigencia de la carga";
        } else if (this.carga.fechaInicio > this.carga.fechaFin) {
            this.errFecha = true;
            this.msjFecha = "Verifique las fechas seleccionadas, la fecha inicial debe ser antes de la fecha final ";
        } else if (!nSel || nSel.length == 0) {
            this.errNegocios = true;
        } else {
            let dialEsp = this.dialogGeneral.iniciarEspera();
            let cargaPost = {
                idCarga: this.carga.idCarga, titulo: this.carga.titulo,
                fechaInicio: this.formatFecha(this.carga.fechaInicio), fechaFin: this.formatFecha(this.carga.fechaFin),
                estatus: this.carga.estatus ? 1 : 0, 
                generarPedidos: this.carga.generarPedidos ? 1 : 0,
                negocios: nSel,
                cedis: cdSel
            };

            this.administracionService.actualizaCarga(cargaPost).subscribe(
                respuestaCargas => {
                    this.dialogGeneral.cerrarEsperaId(dialEsp);
                    if (!respuestaCargas.error) {
                        this.actualizaListaCargas();
                        this.dialogGeneral.mensajeError(respuestaCargas.respuesta, "", 3);
                        this.dialogRef.close();
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

    public actualizaListaCargas() {
        this.datosUsuarioUniformesGlobalService.actualizaListaCargas.emit();
        this.dialogRef.close();
    }

    private formatFecha(d: Date): string {
        let fd = ("0" + d.getDate()).slice(-2) + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + d.getFullYear();
        return fd;
    }
}