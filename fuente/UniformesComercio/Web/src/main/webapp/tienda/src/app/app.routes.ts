import { RouterModule, Routes } from '@angular/router';
import { CategoriasComponent } from './components/tienda/categorias/categorias-component';
import { SolicitudUniformeComponent } from './components/tienda/solicitud_uniforme/solicitud-uniforme-component';
import { EstatusUniformeComponent } from './components/tienda/estatus_uniforme/estatus-uniforme-component';
import { UniformeDescuentoComponent } from './components/tienda/uniforme_descuento/uniforme-descuento-component';
import { EntregaUniformeComponent } from './components/tienda/entrega_uniforme/entrega-uniforme-component';

const APP_ROUTES: Routes = [        
    {   path: 'menu', component: CategoriasComponent    },
    {   path: 'solicita_uniforme/tipo/:tipo', component: SolicitudUniformeComponent },
    {   path: 'estatus_uniforme', component: EstatusUniformeComponent   },
    {   path: 'uniforme_descuento', component: UniformeDescuentoComponent   },
    {   path: 'entrega_uniforme', component: EntregaUniformeComponent   }    
];

export const APP_ROUTING = RouterModule.forRoot(APP_ROUTES);