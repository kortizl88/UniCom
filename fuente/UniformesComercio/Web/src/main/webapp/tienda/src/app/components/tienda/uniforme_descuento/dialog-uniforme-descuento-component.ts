import {Component, Inject} from '@angular/core';
import {MdDialog, MdDialogRef, MD_DIALOG_DATA} from '@angular/material';
import { Router} from '@angular/router';

//Modelo
import { PedidoDescuento } from '../../modelo/pedido_descuento';
import { InformacionPedidoDescuentos } from '../../modelo/informacion_pedido_descuentos';

@Component({
  selector: 'dialog-descuento',
  templateUrl: 'dialog-descuento-component.html',
})
export class DialogDescuentoComponent {    

    public arregloInformacionPedidoDescuentos:InformacionPedidoDescuentos[];
    public pedidoDescuento:PedidoDescuento;
    
    constructor(public dialogRef: MdDialogRef<DialogDescuentoComponent>) { }
      
}

