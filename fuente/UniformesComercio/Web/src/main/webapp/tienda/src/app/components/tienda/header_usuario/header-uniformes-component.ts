import { URLSearchParams } from "@angular/http";
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { NavigationStart } from '@angular/router';
import { MdDialog, MdDialogRef } from '@angular/material';

//WS
import { UsuarioService } from './header-uniformes-service';

//Modelo
import { Menu } from '../../modelo/menu';
import { Usuario } from '../../modelo/usuario';
import { Tienda } from '../../modelo/tienda';


//Servicio Global
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';
import { WSUniformesComercioGlobalService } from '../../servicio/endpoint/ws-uniformes-comercio-global-service';

//Componentes
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';


@Component({
    selector: 'app-header-uniformes',
    templateUrl: './header-uniformes-component.html'
})

export class HeaderUniformesComponent implements OnInit {

    private usuarioService: UsuarioService;
    private datosUsuarioUniformes: DatosUsuarioUniformesGlobalService;
    public usuario: Usuario;
    public menu: Menu;
    public ocultarListaUsuario: boolean;
    public verMenuHeader: boolean;
    public administracion: boolean;
    public logueado: boolean;
    public menuAdmin: Menu[];
    public empleadoPar: number;
    private router: Router;
    private dialogGeneral: DialogGeneralComponent;
    private dialogGuia: DialogGeneralComponent;
    private subs: any;
    private subsMenu: any;
    private empAdm: any;

    constructor(usuarioService: UsuarioService, datosUsuarioUniformes: DatosUsuarioUniformesGlobalService, router: Router, public dialog: MdDialog, public endPointWSUniformesComercio: WSUniformesComercioGlobalService) {
        this.usuario = new Usuario();
        this.usuarioService = usuarioService;
        this.datosUsuarioUniformes = datosUsuarioUniformes;
        this.router = router;
        this.ocultarListaUsuario = true;
        this.verMenuHeader = true;
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.logueado = false;
        this.menuAdmin = [new Menu(1, "Carga Semestral", "Carga Semestral", "/admin/cargas"), new Menu(2, "Reporte", "Reporte", "/admin/reporte")];
        this.menuAdmin[0].sel = true;
        this.router.events.subscribe((event) => {
            if (event instanceof NavigationStart) {
                this.verMenuHeader = true;
                let rut = event.url.split("=")[0];
                console.log("ruta:" + rut);
                switch (rut) {
                    case '/menu': this.verMenuHeader = false;
                        break;
                    case '/admin':
                        this.administracion = true;
                        break;
                    case '/?numEmpleado': this.obtieneParamatroEmpleado();
                        break;
                }
            }
        });

        /*sub evento notificacion login*/
        this.subs = this.datosUsuarioUniformes.notificaLogin.subscribe((respLogin) => {
            if (respLogin.valido) {
                this.logueado = true;
                this.empAdm = respLogin.usr;
            }
            else
                this.logueado = false;
        });
        /*sub evento cambio de menu*/
        this.subs = this.datosUsuarioUniformes.notificaCambioMenu.subscribe((respMenu) => {
           this.selMenu(this.menu, respMenu);
        });
    }

    ngOnInit() {
        this.endPointWSUniformesComercio.setCadenaUrl(document.getElementById('id_endPointWS').textContent.trim());
    }

    ngOndestroy() {
        this.subs.unsubscribe();
    }

    private obtieneParamatroEmpleado() {
        this.empleadoPar = this.getParam('numEmpleado');
        if (!this.empleadoPar) {
            this.dialogGeneral.cerrarEspera();
            this.dialogGeneral.mensajeError("No se proporcionaron los parámetros correctos ", '', 1);
        }
        else {
            this.consultarDatosEmpleado(this.empleadoPar);
        }
    }

    private consultarDatosEmpleado(numEmpleado: number): void {
        this.usuarioService.getDatosUsuario(numEmpleado).subscribe(
            respuestaUsuario => {
                this.usuario = respuestaUsuario.respuesta;
                this.datosUsuarioUniformes.setDatosUsuario(this.usuario);
                this.datosUsuarioUniformes.setTiendaLogin(new Tienda(this.usuario.idPais, String(this.usuario.canal), this.usuario.ceco));
                /*obtener menu*/
                /*				
                this.usuarioService.getMenuUsuario(numEmpleado).subscribe(
                    respuestaMenu => {                    
                        this.menu = respuestaMenu.respuesta;
                        this.datosUsuarioUniformes.setMenu(this.menu);
                        this.router.navigateByUrl('menu');
                        this.dialogGeneral.cerrarEspera();
                    },
                    error => {
                        console.log(error);
                        this.dialogGeneral.cerrarEspera();
                        this.dialogGeneral.mensajeError("Ocurrio un problema al consumir los WS getMenuUsuario",error,1);
                    }
                );*/
                this.usuarioService.getMenuFuncionNegocio(numEmpleado, this.datosUsuarioUniformes.getDatosUsuario().funcionSAP, this.datosUsuarioUniformes.getDatosUsuario().negocio).subscribe(
                    respuestaMenu => {
                        this.menu = respuestaMenu.respuesta;
                        this.datosUsuarioUniformes.setMenu(this.menu);
                        this.router.navigateByUrl('menu');
                        this.dialogGeneral.cerrarEspera();
                    },
                    error => {
                        console.log(error);
                        this.dialogGeneral.cerrarEspera();
                        this.dialogGeneral.mensajeError("Ocurrio un problema al consumir los WS getMenuFuncionNegocio", error, 1);
                    }
                );
            },
            error => {
                this.dialogGeneral.cerrarEspera();
                this.dialogGeneral.mensajeError("Ocurrio un problema al consumir los WS getDatosUsuario", error, 1);
            }
        );
    }

    public selMenu(menu: any, mn: any): void {
        if (menu) {
            menu.forEach(menu => {
                menu.sel = false;
            });
            mn.sel = true;
        }
    }
    /*
    * Recupera el parametros de la URL, que enviará el navegador del mago
    */
    private getParam(nombrePar: any) {
        let params = new URLSearchParams(window.location.search.slice(1));
        let valorPar = params.get(nombrePar);
        return Number(valorPar);
    }

}
