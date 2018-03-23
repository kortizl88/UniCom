import { Component } from '@angular/core';
//Servicios global
/*import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';


//Modelo
import { Menu } from '../../modelo/menu';
import { Usuario } from '../../modelo/usuario';*/

import { MdDialog, MdDialogRef } from '@angular/material';
import { ModalCargaSemestralComponent } from './modal-carga-semestral-component';

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

    constructor(public dialog: MdDialog) {
        this.estatus = [{ id: 1, desc: 'solicitado' }, { id: 2, desc: 'solicitado tienda' }, { id: 3, desc: 'solicitado CD' }];
        this.tiendas = [{ tienda: 100, nombre: 'EKT LA LUNA' }, { tienda: 673, nombre: 'MEGA MIRAMONTES' }, { tienda: 2244, nombre: 'MEGA AV AZTECAS' }];
    }

    public filtroTiendas(val: string) {
        if (val) {
            const filterValue = val.toLowerCase();
            this.tiendasFil = this.tiendas.filter(tienda => tienda.nombre.toLowerCase().startsWith(filterValue));
            return this.tiendasFil;
        }
        return this.tiendas;
    }

    public mostrarNombreTda(tienda: any): String {
        if (tienda)
            return tienda.nombre;
    }

    public seleccionarCargaModal(): void {
        if (this.filCarga) {
            let dialogCargas: MdDialogRef<ModalCargaSemestralComponent> = this.dialog.open(ModalCargaSemestralComponent);
        }
    }

}