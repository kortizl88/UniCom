import { Component, Inject, NgZone } from '@angular/core';
import { MdDialog, MdDialogRef, MD_DIALOG_DATA } from '@angular/material';
import { EventEmitter } from '@angular/core';

//Modelo
import { Usuario } from '../../modelo/usuario';
import { UsuarioRecibe } from '../../modelo/usuario_recibe';
import { UsuarioHuella } from '../../modelo/usuario_huella';


//WS
import { EntregaService } from './entrega-uniforme-service';
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';
declare var System: any;

/*detalle pedido entrega*/
@Component({
    selector: 'dialog-detalle-entrega-component',
    templateUrl: 'dialog-detalle-entrega-component.html',
})
export class DialogDetalleEntrega {

    public usuarioRecibe: UsuarioRecibe;
    public dialogGeneral: DialogGeneralComponent;
    public usuarioEntrega: Usuario;
    public validoEntrega: boolean;
    public validoRecepcion: boolean;
    public huellaEntrega: boolean;
    public huellaRecepcion: boolean;
    public flujo: number;
    public msjError: String;
    public descargando: boolean;
    public terminoProceso: boolean;
    public bloqueaHuella: boolean;

    constructor(public dialogRef: MdDialogRef<DialogDetalleEntrega>, public dialog: MdDialog, private ngZone: NgZone, public entregaService: EntregaService) {
        this.flujo = 1;
        this.descargando = false;
        this.terminoProceso = false;
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
    }

    ngOnInit() {
        window.entrega = window.entrega || {};
        window.entrega.huella = window.entrega.huella || {};
        window.entrega.huella.validacion = this.validacionHuella.bind(this);
    }

    ngOnDestroy() {
        window.entrega.huella.validacion = null;
    }

    validacionHuella(respuesta: any) {
        this.ngZone.run(() => {
            this.bloqueaHuella = false;
            let respComponente = { valido: null, msj: '', usuarioValida: null };

            if ((this.flujo == 2 || this.flujo == 4)) {
                respComponente.valido = respuesta.PluginResponse.authenticated == 0 ? false : true;
                respComponente.msj = respuesta.PluginResponse.processDetail == "" ? "Ocurri\u00F3 un error al solicitar el componente de Huella" : respuesta.PluginResponse.processDetail;
            } else {
                respComponente = respuesta;
            }

            this.recibeRespuestaComponente(respComponente);
        }
        );
    }

    public recibeRespuestaComponente(respuesta: any) {
        /*Valida el resultado y el flujo que se ejecuto, 
          1 - Confirma Entrega
          2 - Valida huella Entrega
          3 - Confirma Recepcion
          4 - Valida huella recepcion */
        console.log(respuesta);
        if (!respuesta.valido) {
            this.msjError = respuesta.msj;
        }
        else {
            switch (this.flujo) {
                case 1: /* entrega confirmada*/
                case 3:
                    this.iniciaValidaHuella(respuesta.usuarioValida.empleado);
                    break;
                case 2: /* huella entrega confirmada*/
                    this.iniciarRecepcionUniforme(this.usuarioRecibe, this.usuarioEntrega);
                    break;
                case 4: /* huella recepcion confirmada*/
                    this.aplicaDescargaInv();
                    break;
            }
        }
    }

    public iniciaValidaHuella(numEmp: number) {
        console.log('aqui llamo al componente de huella');
        this.bloqueaHuella = true;
        System.import('../../../../assets/js/huella.js')
            .then(huellaJS => {
                huellaJS.validaHuellaEmpleado(numEmp);
            });
    }

    public iniciarEntregaUniforme(usuarioRecibe: UsuarioRecibe, usuarioEntrega: Usuario) {
        let dialogModHuella: MdDialogRef<DialogConfirmaEntrega> = this.dialog.open(DialogConfirmaEntrega);
        dialogModHuella.componentInstance.usuarioRecibe = usuarioRecibe;
        dialogModHuella.componentInstance.usuarioEntrega = usuarioEntrega;
        const sub = dialogModHuella.componentInstance.recibeRespuestaComponente.subscribe((respConfirma) => {
            this.flujo = 2;
            this.iniciaValidaHuella(respConfirma.usuarioValida.empleado);
        });
    }

    public iniciarRecepcionUniforme(usuarioRecibe: UsuarioRecibe, usuarioEntrega: Usuario) {
        let dialogModHuella: MdDialogRef<DialogConfirmaRecibido> = this.dialog.open(DialogConfirmaRecibido);
        dialogModHuella.componentInstance.usuarioRecibe = usuarioRecibe;
        dialogModHuella.componentInstance.usuarioEntrega = usuarioEntrega;
        const sub = dialogModHuella.componentInstance.recibeRespuestaComponente.subscribe((respConfirma) => {
            this.flujo = 4;
            this.iniciaValidaHuella(respConfirma.usuarioValida.empleado);
        });
    }

    public aplicaDescargaInv() {
        this.descargando = true;
        this.entregaService.postEntregaUniformes(this.usuarioRecibe).subscribe(
            respuestaWS => {
                this.descargando = false;
                if (!respuestaWS.error) {
                    this.usuarioRecibe = respuestaWS.respuesta;
                    let erroresDescarga = false;
                    this.usuarioRecibe.pedidos.forEach(ped => {
                        if (ped.errorEntrega) {
                            erroresDescarga = true;
                        }
                    });
                    if (erroresDescarga) {
                        this.msjError = "Ocurrieron errores durante la descarga, por favor, verifique el detalle en cada pedido"
                    }
                    this.terminoProceso = true;
                } else {
                    this.dialogGeneral.mensajeError("Ocurri\u00F3 un error al realizar la descarga de los pedidos", respuestaWS.mensaje, 1);
                    this.msjError = "Ocurrió un error al realizar la descarga de los pedidos";
                    this.terminoProceso = true;
                }
            }, error => {
                this.dialogGeneral.mensajeError("Ocurrió un error al realizar la descarga de los pedidos", error, 1);
            }
        );
    }

}

/*confirmacion entrega uniforme gerente*/
@Component({
    selector: 'dialog-confirma-entrega-component',
    templateUrl: 'dialog-confirma-entrega-component.html',
})
export class DialogConfirmaEntrega {

    public usuarioRecibe: UsuarioRecibe;
    public usuarioEntrega: Usuario;
    public recibeRespuestaComponente: EventEmitter<any>;
    constructor(public dialogRef: MdDialogRef<DialogConfirmaEntrega>, public dialog: MdDialog) {
        this.recibeRespuestaComponente = new EventEmitter<any>();
    }

    public iniciarHuellaEmpleadoEntrega(usuarioRecibe: UsuarioRecibe, usuarioEntrega: Usuario) {
        this.recibeRespuestaComponente.emit({ valido: true, flujo: 1, msj: 'procede a validar huella', usuarioValida: usuarioEntrega });
        this.dialogRef.close();
    }

    public cancelaEntrega() {
        this.recibeRespuestaComponente.emit({ valido: false, flujo: 1, msj: 'Usuario cancel\u00F3 entrega' });
        this.dialogRef.close();
    }
}

/*confirmacion recepcion uniforme empleado*/
@Component({
    selector: 'dialog-confirma-recibido-component',
    templateUrl: 'dialog-confirma-recibido-component.html',
})
export class DialogConfirmaRecibido {

    public usuarioRecibe: UsuarioRecibe;
    public usuarioEntrega: Usuario;
    public recibeRespuestaComponente: EventEmitter<any>;
    constructor(public dialogRef: MdDialogRef<DialogConfirmaRecibido>, public dialog: MdDialog) {
        this.recibeRespuestaComponente = new EventEmitter<any>();
    }

    public iniciarHuellaEmpleadoConfirmacion(usuarioRecibe: UsuarioRecibe, usuarioEntrega: Usuario) {
        this.recibeRespuestaComponente.emit({ valido: true, flujo: 3, msj: 'procede a validar huella', usuarioValida: UsuarioRecibe });
        this.dialogRef.close();
    }

    public cancelaRecepcion() {
        this.recibeRespuestaComponente.emit({ valido: false, flujo: 3, msj: 'Usuario cancel\u00F3 entrega' });
        this.dialogRef.close();
    }
}