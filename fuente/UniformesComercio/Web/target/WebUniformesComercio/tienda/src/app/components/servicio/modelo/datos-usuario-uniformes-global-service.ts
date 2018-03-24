import { Injectable } from '@angular/core';
import { EventEmitter } from '@angular/core';
//Modelo
import { Menu } from '../../modelo/menu';
import { Usuario } from '../../modelo/usuario';
import { Tienda } from '../../modelo/tienda';


@Injectable()
export class DatosUsuarioUniformesGlobalService {
	
    public usuario: Usuario;
    public menu: Menu;
    public tiendaLogin: Tienda;	
    public notificaLogin = new EventEmitter<any>();
    public cargaSeleccionada = new EventEmitter<any>();
    
    constructor() {}
		
    public setDatosUsuario (usuario : Usuario) : void{
	this.usuario = usuario;
    }
	
    public getDatosUsuario () : Usuario{
        return this.usuario;
    }
	
    public setMenu (menu : Menu) : void{
        this.menu = menu;
    }
	
    public getMenu () : Menu{
        return this.menu;
    }
	
    public setTiendaLogin (tiendaLogin : Tienda) : void{
	this.tiendaLogin = tiendaLogin;
    }
	
    public getTiendaLogin () : Tienda{
	return this.tiendaLogin;
    }
	   
}
