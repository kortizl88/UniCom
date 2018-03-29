import { Component } from '@angular/core';

import { MdDialog, MdDialogRef } from '@angular/material';
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';
import { ModalBitacoraSolicitudComponent } from '../../administracion/reporte/modal-bitacora-solicitud-component';

@Component({
    selector: 'modal-detalle-solicitud',
    templateUrl: './modal-detalle-solicitud.html'
})

export class ModalDetalleSolicitudComponent {
    public dialogGeneral: DialogGeneralComponent;
    public solicitud:any;

    constructor(public dialog: MdDialog, public dialogRef: MdDialogRef<ModalDetalleSolicitudComponent> ) {
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
    }

    public verBitacora(solicitud:number){
        let dialogDetalle: MdDialogRef<ModalBitacoraSolicitudComponent> = this.dialog.open(ModalBitacoraSolicitudComponent);
        dialogDetalle.componentInstance.solicitud = solicitud;
        dialogDetalle.componentInstance.consultaBitacora(solicitud);
    }


}