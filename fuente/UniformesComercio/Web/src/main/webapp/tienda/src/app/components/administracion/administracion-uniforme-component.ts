import { ActivatedRoute, Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';

//Servicios global
import { DatosUsuarioUniformesGlobalService } from '../servicio/modelo/datos-usuario-uniformes-global-service';


//Modelo
/*import { Menu } from '../../modelo/menu';
import { Usuario } from '../../modelo/usuario';*/


@Component({
    selector: 'app-admin',
    templateUrl: './administracion-component.html'
})

export class AdministracionComponent{

    public usr:number;
    public pass:string;

    constructor( private router: Router, private datosUsuarioUniformesGlobalService: DatosUsuarioUniformesGlobalService ){

    }

    public validaAcceso(){
        this.datosUsuarioUniformesGlobalService.notificaLogin.emit({ valido: true});
        this.router.navigate(['/admin/cargas']);
    }

}