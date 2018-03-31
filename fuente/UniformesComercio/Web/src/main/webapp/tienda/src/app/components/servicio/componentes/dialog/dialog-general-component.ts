import { Component, Injectable } from '@angular/core';
import { MdDialog, MdDialogRef, MD_DIALOG_DATA } from '@angular/material';
import { Router } from '@angular/router';

@Injectable()
export class DialogGeneralComponent {

    private dialogRefSicrono: MdDialogRef<DialogSicronoComponent>;

    constructor(public dialog: MdDialog) { }

    public iniciarEspera(): MdDialogRef<DialogSicronoComponent> {
        this.dialogRefSicrono = this.dialog.open(DialogSicronoComponent, { disableClose: true });
        document.getElementById('id-dialog-sincrono').parentElement.parentElement.parentElement.className += " dialog-sincrono-transparente";
        return this.dialogRefSicrono;
    }

    public cerrarEspera(): void {
        this.dialogRefSicrono.close();
    }

    public cerrarEsperaId(dial: MdDialogRef<DialogSicronoComponent>): void {
        dial.close();
    }

    public mensajeError(msjResumenError: string, msjError: string, numero: number): void {
        let dialogRefError: MdDialogRef<DialogErrorComponent> = this.dialog.open(DialogErrorComponent, { disableClose: true });
        let estiloDialog = document.getElementById('id-dialog-error');
        estiloDialog.parentElement.parentElement.className += " mat-dialog-container-error";
        dialogRefError.componentInstance.cadenaHeader = this.tipoHeader(numero);
        dialogRefError.componentInstance.cadenaResumenError = msjResumenError;
        dialogRefError.componentInstance.cadenaError = null;
        if (msjError && msjError != '') {
            dialogRefError.componentInstance.cadenaError = msjError;
        }
        dialogRefError.componentInstance.tipoColor = this.tipoMensajeError(numero);
        dialogRefError.componentInstance.nombreImagen = this.tipoImagen(numero);
        dialogRefError.componentInstance.tipoDialog = numero;
        this.configuraDialog(numero, dialogRefError);
    }

    private tipoHeader(numero: number) {
        switch (numero) {
            case 1:
                return 'Atención';
            case 2:
                return 'Advertencia';
            case 3:
                return 'Correcto';
        }
    }

    private tipoMensajeError(numero: number): string {
        switch (numero) {
            case 1: //ERROR
                return '#FF5252';
            case 2:
                return '#FFCA28';
            case 3:
                return '#26A69A';
        }
    }

    private tipoImagen(numero: number): string {
        switch (numero) {
            case 1:
                return 'error.png';
            case 2:
                return 'advertencia.png';
            case 3:
                return 'correcto.png';
        }
    }

    private configuraDialog(numero: number, dialog: MdDialogRef<DialogErrorComponent>): void {
        switch (numero) {
            case 1: //ERROR
                dialog.componentInstance.ocultarSalir = true;
                break;
            case 2: //ADVERTENCIA
                dialog.componentInstance.ocultarSalir = true;
                break;
            case 3: //CORRECTO
                dialog.componentInstance.ocultarRegresar = true;
                dialog.componentInstance.ocultarVerMas = true;
        }
    }

    public guia() {
        let dialogGuia: MdDialogRef<DialogGuiaComponent> = this.dialog.open(DialogGuiaComponent, { disableClose: true });
    }

}

/*mensaje de espera*/
@Component({
    selector: 'dialog-sincrono-component',
    templateUrl: 'dialog-sincrono-component.html',
})
export class DialogSicronoComponent {
    constructor(public dialogRef: MdDialogRef<DialogSicronoComponent>) { }
}

/*mensaje error*/
@Component({
    selector: 'dialog-error-component',
    templateUrl: 'dialog-error-component.html',
})
export class DialogErrorComponent {

    private _cadenaHeader: string;
    private _cadenaResumenError: string;
    private _cadenaError: string;
    private _tipoColor: string;
    private _nombreImagen: string;
    private _aumento: string;
    private _estiloDialog: HTMLElement;
    private _ocultarErrorCompleto: boolean;
    private _tipoDialog: number;
    private _ocultarVerMas: boolean;
    private _ocultarRegresar: boolean;
    private _ocultarSalir: boolean;

    constructor(public dialogRef: MdDialogRef<DialogErrorComponent>, private router: Router) {
        this._ocultarErrorCompleto = true;
    }

    public regresarMenu(): void {
        this.router.navigateByUrl('menu');
    }

    public verMas(): void {
        this._ocultarErrorCompleto = !this._ocultarErrorCompleto;
    }

    get ocultarErrorCompleto() {
        return this._ocultarErrorCompleto;
    }

    set cadenaHeader(cadena: string) {
        this._cadenaHeader = cadena;
    }

    get cadenaHeader() {
        return this._cadenaHeader;
    }

    set cadenaResumenError(cadena: string) {
        this._cadenaResumenError = cadena;
    }

    get cadenaResumenError() {
        return this._cadenaResumenError;
    }

    set cadenaError(cadena: string) {
        this._cadenaError = cadena;
    }

    get cadenaError() {
        return this._cadenaError;
    }

    set tipoColor(tipoColor: string) {
        this._tipoColor = tipoColor;
    }

    get tipoColor() {
        return this._tipoColor;
    }

    set nombreImagen(nombreImagen: string) {
        this._nombreImagen = nombreImagen;
    }

    get nombreImagen() {
        return this._nombreImagen;
    }

    set estiloDialog(estiloDialog: any) {
        this._estiloDialog = estiloDialog;
    }

    set tipoDialog(numero: number) {
        this._tipoDialog = numero;
    }

    set ocultarVerMas(bandera: boolean) {
        this._ocultarVerMas = bandera;
    }

    get ocultarVerMas() {
        return this._ocultarVerMas;
    }

    set ocultarRegresar(bandera: boolean) {
        this._ocultarRegresar = bandera;
    }

    get ocultarRegresar() {
        return this._ocultarRegresar;
    }

    set ocultarSalir(bandera: boolean) {
        this._ocultarSalir = bandera;
    }

    get ocultarSalir() {
        return this._ocultarSalir;
    }

}

/*mensaje error*/
@Component({
    selector: 'dialog-guia-component',
    templateUrl: 'dialog-guia-component.html',
})
export class DialogGuiaComponent {
    constructor(public dialogRef: MdDialogRef<DialogGuiaComponent>) { }
}

