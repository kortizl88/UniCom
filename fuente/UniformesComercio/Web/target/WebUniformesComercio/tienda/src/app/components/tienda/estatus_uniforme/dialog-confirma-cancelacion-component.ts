import { Component, Inject } from '@angular/core';
import { MdDialog, MdDialogRef, MD_DIALOG_DATA } from '@angular/material';
import { Router } from '@angular/router';
import { Solicitud } from '../../modelo/solicitud';

/*confirma solicitud*/
@Component({
  selector: 'dialog-confirma-cancelacion-component',
  templateUrl: 'dialog-confirma-cancelacion-component.html',
})
export class DialogConfirmaCancelacionComponent {

  public solicitud: Solicitud;

  constructor(public dialogRef: MdDialogRef<DialogConfirmaCancelacionComponent>) {}

}
