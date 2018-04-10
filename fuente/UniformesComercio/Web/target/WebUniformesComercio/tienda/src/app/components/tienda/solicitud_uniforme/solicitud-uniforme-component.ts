import { Component, OnInit } from '@angular/core';
import { OnDestroy } from '@angular/core';
import { MdDialog, MdDialogRef } from '@angular/material';
import { Router, ActivatedRoute, ParamMap } from "@angular/router";
import { NgxSiemaOptions, NgxSiemaService } from 'ngx-siema';
import { NavigationStart } from '@angular/router';

//Modelo
import { Usuario } from '../../modelo/usuario';
import { Tienda } from '../../modelo/tienda';


//Servicio Global
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';


//WS
import { SolicitudService } from './solicitud-uniforme-service';


//Componentes
import {
    DialogImagenCompletaComponent,
    DialogTiendasCercanasComponent,
    DialogNuevosIngresosComponent,
    DialogRespuestaSolicitudComponent,
    DialogConfirmaSolicitudComponent
} from './dialog-solicitud-uniforme-component';
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';

@Component({
    selector: 'app-solicitud-uniforme',
    templateUrl: './solicitud-uniforme-component.html'
})
export class SolicitudUniformeComponent implements OnInit, OnDestroy {

    public usuarioLogueado: Usuario;
    public tiendaLogin: Tienda;
    public empleadosSolicita: number;
    public tipoSolicitud: number;
    public tiendaSolicitud: Tienda;
    public solicitudEmplados: any;
    public totalsolicitud: number;
    public obsCambioParametro: any = null;
    public esIndividual: boolean;
    public dialogGeneral: DialogGeneralComponent;

    constructor(public dialog: MdDialog,
        public route: ActivatedRoute,
        public router: Router,
        datosUsuarioUniformes: DatosUsuarioUniformesGlobalService,
        public solicitudService: SolicitudService,
        public ngxSiemaService: NgxSiemaService
    ) {
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.route.params.subscribe(params => {
            this.tipoSolicitud = Number((params.tipo == 4 ? 1 : params.tipo));/*sol voluntaria*/
            this.esIndividual = (params.tipo == 4 ? true : false);
        });
        this.usuarioLogueado = datosUsuarioUniformes.getDatosUsuario();
        this.tiendaLogin = datosUsuarioUniformes.getTiendaLogin();
        this.totalsolicitud = 0;
        this.tiendaSolicitud = this.tiendaLogin;
        this.consultaInfoTienda(true);
    }

    ngOnInit() {
        this.obsCambioParametro = this.router.events.subscribe((event) => {
            if (event instanceof NavigationStart) {
                if (event.url.indexOf("solicita_uniforme/tipo") > -1) {
                    let strPar = event.url.split("/");
                    let parT = Number(strPar[strPar.length - 1]);
                    if (parT != this.tipoSolicitud || (parT == 1 && this.esIndividual)) {
                        if (parT == 4) {/*sol semestral individual*/
                            this.tipoSolicitud = 1;
                            this.esIndividual = true;
                        } else {
                            this.tipoSolicitud = parT;
                            this.esIndividual = false;
                        }
                        this.consultaInfoTienda(true);
                    }
                }
            }
        });

    }

    ngOnDestroy() {
        this.obsCambioParametro.unsubscribe();
    }

    /**
     * Funcion para desplazar la imagen de uniformes
     */
    public next(): void {
        this.ngxSiemaService.next(1)
            .subscribe((data: any) => {
                console.log(data);
            });
    }

    /**
     * Funcion para desplazar la imagen de uniformes
     */
    public prev(): void {
        // Use the prev function only for ngx-siema instance with selector '.siema'
        this.ngxSiemaService.prev(1, '.siema')
            .subscribe((data: any) => {
                console.log(data);
            });
    }

    /**
     * Configuracion del componente NgxSiema 
     * */
    options: NgxSiemaOptions = {
        selector: '.siema',
        duration: 200,
        easing: 'ease-out',
        perPage: 1,
        startIndex: 0,
        draggable: true,
        threshold: 20,
        loop: true,
        onInit: () => {
            // runs immediately after first initialization

        },
        onChange: () => {
            // runs after slide change

        },
    };

    public buscaTiendaSolicitud() {
        this.consultaInfoTienda(false);
    }

    public consultaInfoTienda(validaEmpleado: boolean) {
        let dialEsp = this.dialogGeneral.iniciarEspera();
        this.solicitudService.getInfoTienda(this.tiendaLogin.pais, this.tiendaLogin.canal, this.tiendaLogin.sucursal).subscribe(
            respuestaTienda => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestaTienda.error) {
                    setTimeout(() => {
                        if (respuestaTienda.respuesta.tiendaReceptora == 1) {/*La tienda puede entregar uniformes*/
                            this.tiendaSolicitud = respuestaTienda.respuesta;
                            this.validaEmpleado();
                        } else {/*seleccionar tienda receptora*/
                            let dialEspTC = this.dialogGeneral.iniciarEspera();
                            this.solicitudService.getTiendasCercanas(this.tiendaLogin.pais, this.tiendaLogin.canal, this.tiendaLogin.sucursal).subscribe(
                                respuestaTiendasCercanas => {
                                    this.dialogGeneral.cerrarEsperaId(dialEspTC);
                                    if (!respuestaTienda.error) {
                                        let dialogTiendasCercanas: MdDialogRef<DialogTiendasCercanasComponent> = this.dialog.open(DialogTiendasCercanasComponent, { disableClose: true });
                                        dialogTiendasCercanas.componentInstance.tiendas = respuestaTiendasCercanas.respuesta;
                                        dialogTiendasCercanas.afterClosed().subscribe(
                                            tiendaSel => {
                                                this.tiendaSolicitud = tiendaSel;
                                                if (validaEmpleado)
                                                    this.validaEmpleado();
                                            }
                                        );
                                    } else {
                                        this.dialogGeneral.cerrarEsperaId(dialEspTC);
                                        this.dialogGeneral.mensajeError("Ocurrió un error al consultar las tiendas cercanas", respuestaTienda.mensaje, 1);
                                    }
                                }, error => {
                                    this.dialogGeneral.cerrarEsperaId(dialEspTC);
                                    this.dialogGeneral.mensajeError("Error al consultar las tiendas cercanas", "", 1);
                                }
                            );
                        }
                    }, 100);
                } else {
                    this.dialogGeneral.cerrarEsperaId(dialEsp);
                    this.dialogGeneral.mensajeError("Error al consultar la información de la tienda", "", 1);
                }
            }, error => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                this.dialogGeneral.mensajeError("Error al consultar la información de la tienda", "", 1);
            }
        );
    }

    public muestraGuiaTallas(genero: string) {
        let dialogRefImagenCompleta: MdDialogRef<DialogImagenCompletaComponent> = this.dialog.open(DialogImagenCompletaComponent);
        dialogRefImagenCompleta.componentInstance.genero = genero;
    }

    public validaEmpleado() {
        switch (this.tipoSolicitud) {
            case 1:/*solicitud semestral*/
                if (this.usuarioLogueado.solicitudPlantilla == 1 && this.esIndividual == false) {/*consultar la plantilla de la tienda*/
                    this.consultaKitTienda(this.usuarioLogueado.idPais, this.usuarioLogueado.canal, this.usuarioLogueado.ceco, this.tipoSolicitud);
                } else {/*consultar propio kit*/
                    this.consultaKitEmpleado(this.usuarioLogueado.empleado, this.tipoSolicitud);
                }
                break;
            case 2:/*solicitud voluntaria*/
                /*consultar propio kit*/
                this.consultaKitEmpleado(this.usuarioLogueado.empleado, this.tipoSolicitud);
                break;
            case 3:/*solicitud nuevo ingreso*/
                /*consultar los empleados de nuevo ingreso*/
                this.consultaEmpleadosNuevoIngreso(this.tiendaSolicitud.sucursal);
        }
    }

    public consultaKitEmpleado(numEmp: number, tipo: number) {
        let dialEsp = this.dialogGeneral.iniciarEspera();
        this.solicitudService.getKitEmpleado(numEmp, tipo).subscribe(
            respuestakitUsuario => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestakitUsuario.error) {
                    this.solicitudEmplados = respuestakitUsuario.respuesta;
                    this.muestraGuiaTallas(this.solicitudEmplados[0].genero);
                } else {
                    this.router.navigateByUrl('menu');
                    this.dialogGeneral.mensajeError(respuestakitUsuario.mensaje, "", 1);
                }
            }, error => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                console.log(error);
            }
        );
    }

    public consultaKitTienda(pais: number, canal: number, sucursal: number, tipo: number) {
        let dialEsp = this.dialogGeneral.iniciarEspera();
        this.solicitudService.getKitEmpleadosTienda(pais, canal, sucursal, tipo).subscribe(
            respuestakitUsuarios => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestakitUsuarios.error) {
                    this.solicitudEmplados = respuestakitUsuarios.respuesta;
                } else {
                    this.router.navigateByUrl('menu');
                    this.dialogGeneral.mensajeError(respuestakitUsuarios.mensaje, "", 1);
                }
            }, error => {
                console.log(error);
            }
        );
    }

    public consultaEmpleadosNuevoIngreso(sucursal: number) {
        let dialEsp = this.dialogGeneral.iniciarEspera();
        this.solicitudService.getEmpleadosNuevoIngreso(sucursal).subscribe(
            respuestaNuevosIngresos => {
                this.dialogGeneral.cerrarEsperaId(dialEsp);
                if (!respuestaNuevosIngresos.error) {
                    let dialogNuevoIngreso: MdDialogRef<DialogNuevosIngresosComponent> = this.dialog.open(DialogNuevosIngresosComponent, { disableClose: true });
                    dialogNuevoIngreso.componentInstance.empleados = respuestaNuevosIngresos.respuesta;
                    dialogNuevoIngreso.afterClosed().subscribe(
                        empleadoSel => {
                            if (empleadoSel) {
                                this.consultaKitEmpleado(empleadoSel.empleado, this.tipoSolicitud);
                            } else {
                                this.router.navigateByUrl('menu');
                            }
                        }
                    );
                } else {
                    this.dialogGeneral.mensajeError(respuestaNuevosIngresos.mensaje, "", 1);
                }
            }, error => {
                console.log(error);
            }
        );
    }

    public cantidadPorPrenda(prenda: any) {
        if (this.tipoSolicitud == 1 && (prenda.minimo == prenda.maximo)) /*pre seleccionar la cantidad, ya que es el mismo min y max*/ {
            prenda.cantidad = prenda.maximo;
        }
        let arNum = [];
        for (var i = prenda.minimo; i <= prenda.maximo; i++) {
            arNum.push(i);
        }

        return arNum;
    }

    public actualizaTotal() {
        this.totalsolicitud = 0;
        for (let sol of this.solicitudEmplados) {
            for (let prenda of sol.kit.prendas) {
                if (prenda.cantidad)
                    this.totalsolicitud += prenda.cantidad * prenda.precio;
            }
        }
    }

    public guardaSolicitud() {
        let solicitudArr = [];
        let solValida = true;
        let solVacia = true;
        for (let sol of this.solicitudEmplados) {
            let objSol: any = {};
            objSol.numEmp = sol.empleado;
            objSol.tipo = this.tipoSolicitud;
            objSol.negocio = this.usuarioLogueado.negocio;
            objSol.funcion = sol.funcion;
            objSol.numEmpCaptura = this.usuarioLogueado.empleado;
            let arrPrenda = [];
            for (let prenda of sol.kit.prendas) {
                if (prenda.cantidad && prenda.cantidad > 0) {

                    if (prenda.tallaSeleccionada) {
                        let prendaO: any = {};
                        prendaO.pais = this.tiendaSolicitud.pais;
                        prendaO.canal = this.tiendaSolicitud.canal;
                        prendaO.sucursal = this.tiendaSolicitud.sucursal;
                        prendaO.idTipoPrenda = prenda.idTipoPrenda;
                        prendaO.idTalla = prenda.tallaSeleccionada.idTalla;
                        prendaO.cantidad = prenda.cantidad;
                        prendaO.precioUnitario = prenda.precio;
                        arrPrenda.push(prendaO);
                        solVacia = false;
                    } else {
                        prenda.error = true;
                        solValida = false;
                    }
                }
            }
            objSol.detalle = arrPrenda;
            solicitudArr.push(objSol);
        }
        if (solValida && solicitudArr.length > 0 && !solVacia) {
            let dialConfSol: MdDialogRef<DialogConfirmaSolicitudComponent> = this.dialog.open(DialogConfirmaSolicitudComponent, { disableClose: true });
            dialConfSol.componentInstance.solicitudes = this.solicitudEmplados;
            dialConfSol.afterClosed().subscribe(
                respConfirma => {
                    if (respConfirma) {
                        let dialEsp = this.dialogGeneral.iniciarEspera();
                        this.solicitudService.guardaSolicitud(solicitudArr).subscribe(
                            respuestaGuardaSol => {
                                this.dialogGeneral.cerrarEsperaId(dialEsp);
                                if (!respuestaGuardaSol.error) {
                                    let dialRespSol: MdDialogRef<DialogRespuestaSolicitudComponent> = this.dialog.open(DialogRespuestaSolicitudComponent, { disableClose: true });
                                    dialRespSol.componentInstance.solicitudes = respuestaGuardaSol.respuesta;
                                    dialRespSol.afterClosed().subscribe(
                                        respSol => {
                                            if ( (this.tipoSolicitud == 1 && this.esIndividual) || (this.tipoSolicitud == 2) ) {
                                                this.router.navigateByUrl('estatus_uniforme');
                                            } else {
                                                this.router.navigateByUrl('menu');
                                            }
                                        }
                                    );
                                } else {
                                    this.dialogGeneral.mensajeError(respuestaGuardaSol.mensaje, "", 1);
                                }
                            }, error => {
                                console.log(error);
                            }
                        );
                    }
                }
            );
        }
    }
}