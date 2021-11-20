import { NgModule } from '@angular/core';
import { RouterModule, Routes, CanActivate } from '@angular/router';
import { AddReportComponent } from './pages/reports/add-report/add-report.component';
import { AdminRoleGuard } from '../guards/admin-role.guard';
import { AsignarReportComponent } from './pages/reports/asignar-report/asignar-report.component';
import { ChatComponent } from './pages/chat/chat.component';
import { HomeComponent } from './pages/home/home.component';
import { InstituteRoleGuard } from '../guards/institute-role.guard';
import { InstitutesComponent } from './pages/institutes/institutes/institutes.component';
import { MyReportEditComponent } from './ins/my-report-edit/my-report-edit.component';
import { MyReportsComponent } from './ins/my-reports/my-reports.component';
import { MyReportsPendientesComponent } from './ins/my-reports-pendientes/my-reports-pendientes.component';
import { ReportsComponent } from './pages/reports/reports/reports.component';
import { ReportsPendientesComponent } from './pages/reports/reports-pendientes/reports-pendientes.component';
import { StatisticsComponent } from './pages/statistics/statistics/statistics.component';
import { ReportComponent } from './pages/reports/report/report.component';
import { EstadisticasComponent } from './pages/statistics/estadisticas/estadisticas.component';
import { AddInstituteComponent } from './pages/institutes/add-institute/add-institute.component';
import { InstituteComponent } from './pages/institutes/institute/institute.component';
import { NewsComponent } from './pages/news/news/news.component';
import { AddNewComponent } from './pages/news/add-new/add-new.component';
import { NewComponent } from './pages/news/new/new.component';
import { TipsComponent } from './pages/tips/tips/tips.component';
import { AddTipComponent } from './pages/tips/add-tip/add-tip.component';
import { TipComponent } from './pages/tips/tip/tip.component';
import { EventsComponent } from './pages/events/events/events.component';
import { EventComponent } from './pages/events/event/event.component';
import { AddEventComponent } from './pages/events/add-event/add-event.component';

const routes: Routes = [
  {
    path: '',
    component: HomeComponent,
    children: [
        {
            path: 'reports',
            component: ReportsComponent,
            canActivate: [ AdminRoleGuard ],

        },
        {
            path: 'report/:id',
            component: ReportComponent,
            canActivate: [ AdminRoleGuard ],

        },
        {
            path: 'report/edit/:id',
            component: AddReportComponent,
            canActivate: [ AdminRoleGuard ],

        },
        {
            path: 'pending-reports',
            component: ReportsPendientesComponent,
            canActivate: [ AdminRoleGuard ],

        },
        {
            path: 'pending-report/:id',
            component: AsignarReportComponent,
            canActivate: [ AdminRoleGuard ],
        },
        /* INSTITUTES */
        {
            path: 'institutes',
            component: InstitutesComponent,
            canActivate: [ AdminRoleGuard ],
        },
        {
            path: 'institute/add',
            component: AddInstituteComponent,
            canActivate: [ AdminRoleGuard ],
        },
        {
            path: 'institute/edit/:id',
            component: AddInstituteComponent,
            canActivate: [ AdminRoleGuard ],
        },
        {
            path: 'institute/:id',
            component: InstituteComponent,
            canActivate: [ AdminRoleGuard ],
        }, 
        /* NEWS */
        {
            path: 'news',
            component: NewsComponent,
            canActivate: [ AdminRoleGuard ],

        },
        {
            path: 'new/add',
            component: AddNewComponent,
            canActivate: [ AdminRoleGuard ],
        },
        {
            path: 'new/edit/:id',
            component: AddNewComponent,
            canActivate: [ AdminRoleGuard ],
        },
        {
            path: 'new/:id',
            component: NewComponent,
            canActivate: [ AdminRoleGuard ]
        },
        /* TIPS */
        {
            path: 'tips',
            component: TipsComponent,
            canActivate: [ AdminRoleGuard ],

        },
        {
            path: 'tip/add',
            component: AddTipComponent,
            canActivate: [ AdminRoleGuard ],
        },
        {
            path: 'tip/edit/:id',
            component: AddTipComponent,
            canActivate: [ AdminRoleGuard ],
        },
        {
            path: 'tip/:id',
            component: TipComponent,
            canActivate: [ AdminRoleGuard ]
        },
        /* EVENTS */
        {
            path: 'events',
            component: EventsComponent,
            canActivate: [ AdminRoleGuard ],

        },
        {
            path: 'event/add',
            component: AddEventComponent,
            canActivate: [ AdminRoleGuard ],
        },
        {
            path: 'event/edit/:id',
            component: AddEventComponent,
            canActivate: [ AdminRoleGuard ],
        },
        {
            path: 'event/:id',
            component: EventComponent,
            canActivate: [ AdminRoleGuard ]
        },
        
        
        /* {
            path: 'buscar',
            component: BuscarComponent
        }, */
        {
            path: 'statistics',
            component: StatisticsComponent,
            canActivate: [ AdminRoleGuard ],
        },
        {
            path: 'statistics/municipios',
            component: EstadisticasComponent,
            canActivate: [ AdminRoleGuard ],
        },
        {
            path: 'chat',
            component: ChatComponent,
            canActivate: [ AdminRoleGuard ],
        },






        /* RUTAS INSTITUTE ROLE */
        {
            path: 'my-reports',
            component: MyReportsComponent,
            canActivate: [ InstituteRoleGuard ],
        },
        {
            path: 'my-reports-pendientes',
            component: MyReportsPendientesComponent,
            canActivate: [ InstituteRoleGuard ],
        },
        {
            path: 'my-report/:id',
            component: MyReportEditComponent,
            canActivate: [ InstituteRoleGuard ],
        },

        {
            path: '**',
            redirectTo: 'reports'
        } 
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DashboardRoutingModule { }