import { ActivatedRoute, Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';
//Servicios global
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';


//Modelo
import { Menu } from '../../modelo/menu';
import { Usuario } from '../../modelo/usuario';


@Component({
    selector: 'app-categorias',
    templateUrl: './categorias-component.html'
})

export class CategoriasComponent implements OnInit {

    public menu:Menu;
    public usuario: Usuario;
    public datosUsuarioUniformes:DatosUsuarioUniformesGlobalService;
	
    constructor(datosUsuarioUniformes: DatosUsuarioUniformesGlobalService){
	this.datosUsuarioUniformes = datosUsuarioUniformes;	
    }

    ngOnInit(){
        this.usuario = this.datosUsuarioUniformes.getDatosUsuario();
	this.menu = this.datosUsuarioUniformes.getMenu();
    }

}