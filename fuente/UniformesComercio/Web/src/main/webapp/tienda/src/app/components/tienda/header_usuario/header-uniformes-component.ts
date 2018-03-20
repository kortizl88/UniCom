import { URLSearchParams } from "@angular/http";
import { Component, OnInit } from '@angular/core';
import { Router} from '@angular/router';
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
    public ocultarListaUsuario:boolean;
    public verMenuHeader:boolean;
    private router:Router;
    private dialogGeneral:DialogGeneralComponent;
    private dialogGuia:DialogGeneralComponent;
   
    constructor(usuarioService:UsuarioService, datosUsuarioUniformes:DatosUsuarioUniformesGlobalService, router: Router, public dialog: MdDialog, public endPointWSUniformesComercio:WSUniformesComercioGlobalService) {
	this.usuario =	new Usuario();		
	this.usuarioService = usuarioService;
        this.datosUsuarioUniformes = datosUsuarioUniformes;
	this.router = router;
	this.ocultarListaUsuario = true;
        this.verMenuHeader = false;
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.dialogGeneral.iniciarEspera();
        this.dialogGeneral.guia();		 	
	this.router.events.subscribe((event) => {
            if (event instanceof NavigationStart) {
		if(event.url != '/menu'){
                    this.verMenuHeader = true;
		}else{
                    this.verMenuHeader = false;
		}
            }
	});
    }

    ngOnInit() {
	let numeroEmpleadoPar = this.getParam('numEmpleado');
/*	let pais = this.getParam('pais');
	let canal = this.getParam('canal');
	let tienda = this.getParam('sucursal');
*/
//      if(!numeroEmpleadoPar || !pais || !canal || !tienda){	
        if(!numeroEmpleadoPar){		
            this.dialogGeneral.cerrarEspera();						
            this.dialogGeneral.mensajeError("No se proporcionaron los parámetros correctos ",'',1);			
	}
	else{
            /*
            let tiendaCC:string;
			
            if(tienda<1000){
		tiendaCC = "520"+String(tienda);
            }else{
		tiendaCC = "52"+String(tienda);
            }			
            this.endPointWSUniformesComercio.setCadenaUrl(document.getElementById('id_endPointWS').textContent.trim());
            this.consultarDatosEmpleado(numeroEmpleadoPar);
            this.datosUsuarioUniformes.setTiendaLogin( new Tienda( pais, String(canal), Number(tiendaCC) ) );
            */		
            this.endPointWSUniformesComercio.setCadenaUrl(document.getElementById('id_endPointWS').textContent.trim());
            this.consultarDatosEmpleado(numeroEmpleadoPar);
	}
    }
	
    private consultarDatosEmpleado(numEmpleado : number): void {
        this.usuarioService.getDatosUsuario(numEmpleado).subscribe(
            respuestaUsuario => {                   
		this.usuario = respuestaUsuario.respuesta;
		this.datosUsuarioUniformes.setDatosUsuario(this.usuario);
		this.datosUsuarioUniformes.setTiendaLogin( new Tienda( this.usuario.idPais, String(this.usuario.canal), this.usuario.ceco ) );
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
                this.usuarioService.getMenuFuncionNegocio(numEmpleado,this.datosUsuarioUniformes.getDatosUsuario().funcionSAP,this.datosUsuarioUniformes.getDatosUsuario().negocio).subscribe(
                    respuestaMenu => {                    
                        this.menu = respuestaMenu.respuesta;
                        this.datosUsuarioUniformes.setMenu(this.menu);
                        this.router.navigateByUrl('menu');
                        this.dialogGeneral.cerrarEspera();
                    },
                    error => {
                        console.log(error);
                        this.dialogGeneral.cerrarEspera();
                        this.dialogGeneral.mensajeError("Ocurrio un problema al consumir los WS getMenuFuncionNegocio",error,1);
                    }
                );
            },
            error => {		
                this.dialogGeneral.cerrarEspera();
		this.dialogGeneral.mensajeError("Ocurrio un problema al consumir los WS getDatosUsuario",error,1);
            }
        );
    }
	
    /*
    * Recupera el parametros de la URL, que enviará el navegador del mago
    */
    private getParam(nombrePar:any){
	let params = new URLSearchParams(window.location.search.slice(1));
	let valorPar = params.get(nombrePar);
        return Number(valorPar);
    }

}
