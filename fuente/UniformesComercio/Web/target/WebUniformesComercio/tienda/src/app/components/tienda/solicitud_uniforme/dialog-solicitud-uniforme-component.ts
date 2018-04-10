import { Component, Inject } from '@angular/core';
import { MdDialog, MdDialogRef, MD_DIALOG_DATA } from '@angular/material';
import { Router } from '@angular/router';

//Componente
import { SolicitudUniformeComponent } from './solicitud-uniforme-component';


/*guia de seleccion de tallas*/
@Component({
  selector: 'dialog-imagen-completa-component',
  templateUrl: 'dialog-imagen-completa-component.html',
})
export class DialogImagenCompletaComponent {

  public genero: string;

  constructor(public dialogRef: MdDialogRef<DialogImagenCompletaComponent>) { }
}

/*tiendas cercanas*/
@Component({
  selector: 'dialog-tiendas-cercanas-component',
  templateUrl: 'dialog-tiendas-cercanas-component.html',
})
export class DialogTiendasCercanasComponent {

  public solicitudUniformeComponent: SolicitudUniformeComponent;
  public tiendas: any;
  public tiendaSeleccionada: any;

  constructor(public dialogRef: MdDialogRef<DialogTiendasCercanasComponent>) { }

}

/*empleado nuevo ingreso*/
@Component({
  selector: 'dialog-nuevos-ingresos-component',
  templateUrl: 'dialog-nuevos-ingresos-component.html',
})
export class DialogNuevosIngresosComponent {

  public empleados: any;
  public empleadoSeleccionado: any;

  constructor(public dialogRef: MdDialogRef<DialogNuevosIngresosComponent>) { }

}

/*confirma solicitud*/
@Component({
  selector: 'dialog-confirma-solicitud-component',
  templateUrl: 'dialog-confirma-solicitud-component.html',
})
export class DialogConfirmaSolicitudComponent {

  public solicitudes: any;

  constructor(public dialogRef: MdDialogRef<DialogConfirmaSolicitudComponent>) { }

  public calculaTotalSol(kit: any): number {
    let total = 0;
    kit.forEach(prenda => {
      if (prenda.cantidad > 0 && prenda.tallaSeleccionada) {
        total += prenda.cantidad * prenda.precio;
      }
    });
    return total;
  }

}

/*respuesta solicitud*/
@Component({
  selector: 'dialog-respuesta-solicitud-component',
  templateUrl: 'dialog-respuesta-solicitud-component.html',
})
export class DialogRespuestaSolicitudComponent {

  public solicitudes: any;

  constructor(public dialogRef: MdDialogRef<DialogRespuestaSolicitudComponent>) { }

}