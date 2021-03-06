import { RouterModule, Routes } from '@angular/router';
import { CategoriasComponent } from './components/tienda/categorias/categorias-component';
import { SolicitudUniformeComponent } from './components/tienda/solicitud_uniforme/solicitud-uniforme-component';
import { EstatusUniformeComponent } from './components/tienda/estatus_uniforme/estatus-uniforme-component';
import { UniformeDescuentoComponent } from './components/tienda/uniforme_descuento/uniforme-descuento-component';
import { EntregaUniformeComponent } from './components/tienda/entrega_uniforme/entrega-uniforme-component';
import { AdministracionComponent } from './components/administracion/administracion-uniforme-component';
import { AdministracionCargasComponent } from './components/administracion/cargas/administracion-uniforme-cargas-component';
import { AdministracionReporteComponent } from './components/administracion/reporte/administracion-uniforme-reporte-component';

const APP_ROUTES: Routes = [        
    {   path: 'menu', component: CategoriasComponent    },
    {   path: 'solicita_uniforme/tipo/:tipo', component: SolicitudUniformeComponent },
    {   path: 'estatus_uniforme', component: EstatusUniformeComponent   },
    {   path: 'uniforme_descuento', component: UniformeDescuentoComponent   },
    {   path: 'entrega_uniforme', component: EntregaUniformeComponent   },
    {   path: 'admin', component: AdministracionComponent    },
    {   path: 'admin/cargas', component: AdministracionCargasComponent    },
    {   path: 'admin/reporte', component: AdministracionReporteComponent    }
];

export const APP_ROUTING = RouterModule.forRoot(APP_ROUTES);