import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgxSiemaModule } from 'ngx-siema';
import { Md2Module } from 'md2';
import { NoopAnimationsModule } from '@angular/platform-browser/animations';

/*Ruteo*/
import { APP_ROUTING } from './app.routes';

/*Componentes*/
import { AppComponent } from './app.component';
import { HeaderUniformesComponent } from './components/tienda/header_usuario/header-uniformes-component';
import { CategoriasComponent } from './components/tienda/categorias/categorias-component';
import { SolicitudUniformeComponent } from './components/tienda/solicitud_uniforme/solicitud-uniforme-component';
import { EstatusUniformeComponent } from './components/tienda/estatus_uniforme/estatus-uniforme-component';
import { UniformeDescuentoComponent } from './components/tienda/uniforme_descuento/uniforme-descuento-component';
import { EntregaUniformeComponent, SearchFilterPipe } from './components/tienda/entrega_uniforme/entrega-uniforme-component';

import {
    DialogDetalleEntrega,
    DialogConfirmaEntrega,
    DialogConfirmaRecibido
} from './components/tienda/entrega_uniforme/dialog-entrega-uniforme-component';

import { TableFilteringExample } from './components/utileria/table/table-filtering-example';

import { DialogDescuentoComponent } from './components/tienda/uniforme_descuento/dialog-uniforme-descuento-component';

import {
    DialogImagenCompletaComponent,
    DialogTiendasCercanasComponent,
    DialogNuevosIngresosComponent,
    DialogRespuestaSolicitudComponent,
    DialogConfirmaSolicitudComponent
} from './components/tienda/solicitud_uniforme/dialog-solicitud-uniforme-component';

import {
    MdAutocompleteModule,
    MdButtonModule,
    MdButtonToggleModule,
    MdCardModule,
    MdCheckboxModule,
    MdChipsModule,
    MdCoreModule,
    MdDatepickerModule,
    MdDialogModule,
    MdExpansionModule,
    MdGridListModule,
    MdIconModule,
    MdInputModule,
    MdListModule,
    MdMenuModule,
    MdNativeDateModule,
    MdPaginatorModule,
    MdProgressBarModule,
    MdProgressSpinnerModule,
    MdRadioModule,
    MdRippleModule,
    MdSelectModule,
    MdSidenavModule,
    MdSliderModule,
    MdSlideToggleModule,
    MdSnackBarModule,
    MdSortModule,
    MdTableModule,
    MdTabsModule,
    MdToolbarModule,
    MdTooltipModule
} from '@angular/material';

//WS
import { HttpModule } from '@angular/http';
import { UsuarioService } from './components/tienda/header_usuario/header-uniformes-service';
import { SolicitudService } from './components/tienda/solicitud_uniforme/solicitud-uniforme-service';
import { EstatusService } from './components/tienda/estatus_uniforme/estatus-service';
import { UniformeDescuentoService } from './components/tienda/uniforme_descuento/uniforme-descuento-service';
import { EntregaService } from './components/tienda/entrega_uniforme/entrega-uniforme-service';

//Servicios inyectables
import { DialogGeneralComponent, DialogErrorComponent, DialogSicronoComponent, DialogGuiaComponent } from './components/servicio/componentes/dialog/dialog-general-component';
import { DatosUsuarioUniformesGlobalService } from './components/servicio/modelo/datos-usuario-uniformes-global-service';
import { WSUniformesComercioGlobalService } from './components/servicio/endpoint/ws-uniformes-comercio-global-service';


import { CdkTableModule } from '@angular/cdk';
@NgModule({
    declarations: [
        AppComponent,
        HeaderUniformesComponent,
        CategoriasComponent,
        SolicitudUniformeComponent,
        EstatusUniformeComponent,
        UniformeDescuentoComponent,
        EntregaUniformeComponent,
        TableFilteringExample,
        DialogImagenCompletaComponent,
        DialogTiendasCercanasComponent,
        DialogNuevosIngresosComponent,
        DialogRespuestaSolicitudComponent,
        DialogConfirmaSolicitudComponent,
        DialogDescuentoComponent,
        DialogDetalleEntrega,
        DialogConfirmaEntrega,
        DialogConfirmaRecibido,
        DialogErrorComponent,
        DialogSicronoComponent,
        DialogGuiaComponent,
        SearchFilterPipe

    ],
    imports: [
        NoopAnimationsModule,
        Md2Module,
        BrowserModule,
        APP_ROUTING,
        //Material
        MdAutocompleteModule,
        MdButtonModule,
        MdButtonToggleModule,
        MdCardModule,
        MdCheckboxModule,
        MdChipsModule,
        MdCoreModule,
        MdDatepickerModule,
        MdDialogModule,
        MdExpansionModule,
        MdGridListModule,
        MdIconModule,
        MdInputModule,
        MdListModule,
        MdMenuModule,
        MdNativeDateModule,
        MdPaginatorModule,
        MdProgressBarModule,
        MdProgressSpinnerModule,
        MdRadioModule,
        MdRippleModule,
        MdSelectModule,
        MdSidenavModule,
        MdSliderModule,
        MdSlideToggleModule,
        MdSnackBarModule,
        MdSortModule,
        MdTableModule,
        MdTabsModule,
        MdToolbarModule,
        MdTooltipModule,
        //Tabla Angular
        CdkTableModule,
        MdAutocompleteModule,
        MdButtonModule,
        MdButtonToggleModule,
        MdCardModule,
        MdCheckboxModule,
        MdChipsModule,
        MdCoreModule,
        MdDatepickerModule,
        MdDialogModule,
        MdExpansionModule,
        MdGridListModule,
        MdIconModule,
        MdListModule,
        MdMenuModule,
        MdNativeDateModule,
        MdPaginatorModule,
        MdProgressBarModule,
        MdProgressSpinnerModule,
        MdRadioModule,
        MdRippleModule,
        MdSelectModule,
        MdSidenavModule,
        MdSliderModule,
        MdSlideToggleModule,
        MdSnackBarModule,
        MdSortModule,
        MdTableModule,
        MdTabsModule,
        MdToolbarModule,
        MdTooltipModule,
        NgxSiemaModule.forRoot(),
        HttpModule,
        FormsModule

    ],

    providers: [
        UsuarioService,
        SolicitudService,
        DatosUsuarioUniformesGlobalService,
        EstatusService,
        DialogGeneralComponent,
        UniformeDescuentoService,
        EntregaService,
        WSUniformesComercioGlobalService

    ],

    bootstrap: [AppComponent],

    entryComponents: [
        DialogImagenCompletaComponent,
        DialogTiendasCercanasComponent,
        DialogNuevosIngresosComponent,
        DialogRespuestaSolicitudComponent,
        DialogConfirmaSolicitudComponent,
        DialogDescuentoComponent,
        DialogDetalleEntrega,
        DialogConfirmaEntrega,
        DialogConfirmaRecibido,
        DialogErrorComponent,
        DialogSicronoComponent,
        DialogGuiaComponent

    ] // Component Dialog
})
export class AppModule {

}
