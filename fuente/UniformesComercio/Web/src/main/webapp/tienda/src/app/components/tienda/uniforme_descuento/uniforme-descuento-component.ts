import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { MdDialog, MdDialogRef } from '@angular/material';

import { UniformeDescuentoService } from './uniforme-descuento-service';
import { DatosUsuarioUniformesGlobalService } from '../../servicio/modelo/datos-usuario-uniformes-global-service';

//Modelo
import { SolicitudVoluntaria } from '../../modelo/solicitud_voluntaria';
import { PedidoDescuento } from '../../modelo/pedido_descuento';
import { InformacionPedidoDescuentos } from '../../modelo/informacion_pedido_descuentos';
import { WrapperRespuesta } from '../../modelo/wrapper_respuesta';


//Componentes
import { DialogGeneralComponent } from '../../servicio/componentes/dialog/dialog-general-component';
import { DialogDescuentoComponent } from './dialog-uniforme-descuento-component';


@Component({
    selector: 'app-uniforme-descuento',
    templateUrl: './uniforme-descuento-component.html'
})

export class UniformeDescuentoComponent implements OnInit {

    private dialogGeneral:DialogGeneralComponent;	
    public solicitudesVoluntarias:SolicitudVoluntaria[];
    public solicitudVoluntaria:SolicitudVoluntaria;
	
    constructor(public dialog:MdDialog, public uniformeDescuentoService: UniformeDescuentoService, public datosUsuarioUniformes:DatosUsuarioUniformesGlobalService) {
        this.dialogGeneral = new DialogGeneralComponent(this.dialog);
        this.dialogGeneral.iniciarEspera();
        this.consultarSolicitudesVoluntarias();  
    }

    /**
     * Consumo del servicio web endpoint : 
     */
    private consultarSolicitudesVoluntarias(): void {   
        this.uniformeDescuentoService.getConsultaSolicitudesVoluntarias(this.datosUsuarioUniformes.getDatosUsuario().empleado).subscribe(             
            respuestaWS => {                 
                this.dialogGeneral.cerrarEspera();
                if(!respuestaWS.error){
                    if(this.contieneSolicitudesVoluntarias(respuestaWS)){                
                        this.solicitudesVoluntarias = respuestaWS.respuesta;                        
                        this.solicitudVoluntaria = this.solicitudesVoluntarias[0];                  
                        this.seleccionaFolioSolicitudVoluntaria();       
                    }
                }else{                
                    this.dialogGeneral.cerrarEspera();
                    this.dialogGeneral.mensajeError("Ocurrio un error en el WSUniformesComercio",respuestaWS.mensaje,1);
                }
            },
            error => {                
                this.dialogGeneral.cerrarEspera();
                this.dialogGeneral.mensajeError("Ocurrio un problema al consumir los WS getConsultaSolicitudesVoluntarias",error,1);
            }            
        );              
    }

    ngOnInit(){}
    
    public seleccionaFolioSolicitudVoluntaria(): void{           
        this.consultarPedidosDescuentos(this.solicitudVoluntaria.nofolioSolicitud);     
    }
            
    public pedidosDescuentos:PedidoDescuento[];    
    private totalPedidoDescuento:PedidoDescuento;

    /**
     * Consumo del servicio web endpoint : 
     */
    private consultarPedidosDescuentos(numeroFolioSolicitud:number): void {   
        this.uniformeDescuentoService.getPedidosDescuentos(this.datosUsuarioUniformes.getDatosUsuario().empleado,numeroFolioSolicitud).subscribe(            
            respuestaWS => {       
                this.dialogGeneral.cerrarEspera();                         
                this.pedidosDescuentos = respuestaWS.respuesta;                 
                this.totalPedidoDescuento = this.pedidosDescuentos[this.pedidosDescuentos.length-1];                
            },
            error => {                
                this.dialogGeneral.cerrarEspera();
                this.dialogGeneral.mensajeError("Ocurrio un problema al consumir los WS getPedidosDescuentos",error,1);
            }            
        );              
    }
    
    private arregloInformacionPedidoDescuentos:InformacionPedidoDescuentos[];    

    /**
     * Consumo del servicio web endpoint : 
     */
    private consultarInformacionPedidoDescuentos(pedidoDescuento:PedidoDescuento): void {   
        this.uniformeDescuentoService.getInformacionPedidoDescuentos(this.datosUsuarioUniformes.getDatosUsuario().empleado,this.solicitudVoluntaria.nofolioSolicitud,pedidoDescuento.noPedido).subscribe(            
            respuestaWS => {                      
                this.arregloInformacionPedidoDescuentos = respuestaWS.respuesta;
                this.abrirDialogDescuento(this.arregloInformacionPedidoDescuentos,pedidoDescuento);                    
            },
            error => {                
                this.dialogGeneral.cerrarEspera();
                this.dialogGeneral.mensajeError("Ocurrio un problema al consumir los WS getInformacionPedidoDescuentos",error,1);
            }            
        );              
    }  

    /**
     * Uso del componente del dialog
     */
    private abrirDialogDescuento(arregloInformacionPedidoDescuentos:InformacionPedidoDescuentos[], pedidoDescuento:PedidoDescuento): void {
        let dialogRefDescuento:MdDialogRef<DialogDescuentoComponent> = this.dialog.open(DialogDescuentoComponent);
        dialogRefDescuento.componentInstance.arregloInformacionPedidoDescuentos = arregloInformacionPedidoDescuentos;
        dialogRefDescuento.componentInstance.pedidoDescuento = pedidoDescuento;
    }

    /**
     * Valida si hay se muestra un error en la parte WS, ademas si tiene solicitudes    
     */
    private contieneSolicitudesVoluntarias(respuestaWS:WrapperRespuesta): boolean {        
        if(respuestaWS.error == false){
            if(respuestaWS.respuesta.length == 0){            
                //this.dialogGeneral.mensajeError('No tiene solicitudes disponibles','',2);
                return false;                    
            }else{
                return true;
            }
        }else{
            this.dialogGeneral.mensajeError('Ocurrio un problema en la parte WS','',1);
            return false;                  
        }            
    }

}