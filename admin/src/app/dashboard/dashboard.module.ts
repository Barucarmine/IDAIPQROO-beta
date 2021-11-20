import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AddReportComponent } from './pages/reports/add-report/add-report.component';
import { AsignarReportComponent } from './pages/reports/asignar-report/asignar-report.component';
import { ChartsModule } from "ng2-charts";
import { ChatComponent } from './pages/chat/chat.component';
import { ChatContainerComponent } from './chat-container/chat-container.component';
import { DashboardRoutingModule } from './dashboard-routing.module';
import { ErrorPageComponent } from './error-page/error-page.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { GraficaCategoriesComponent } from './components/grafica-categories/grafica-categories.component';
import { GraficaStatusComponent } from './components/grafica-status/grafica-status.component';
import { HomeComponent } from './pages/home/home.component';
import { ImagePipe } from '../pipes/image.pipe';
import { InstitutesComponent } from './pages/institutes/institutes/institutes.component';
import { MyReportEditComponent } from './ins/my-report-edit/my-report-edit.component';
import { MyReportsComponent } from './ins/my-reports/my-reports.component';
import { MyReportsPendientesComponent } from './ins/my-reports-pendientes/my-reports-pendientes.component';
import { NavbarComponent } from './components/navbar/navbar.component';
import { ReportComponent } from './pages/reports/report/report.component';
import { ReportsComponent } from './pages/reports/reports/reports.component';
import { ReportsPendientesComponent } from './pages/reports/reports-pendientes/reports-pendientes.component';
import { StatisticsComponent } from './pages/statistics/statistics/statistics.component';
import { EstadisticasComponent } from './pages/statistics/estadisticas/estadisticas.component';
import { InstituteComponent } from './pages/institutes/institute/institute.component';
import { AddInstituteComponent } from './pages/institutes/add-institute/add-institute.component';
import { NewsComponent } from './pages/news/news/news.component';
import { NewComponent } from './pages/news/new/new.component';
import { AddNewComponent } from './pages/news/add-new/add-new.component';
import { AddTipComponent } from './pages/tips/add-tip/add-tip.component';
import { TipComponent } from './pages/tips/tip/tip.component';
import { TipsComponent } from './pages/tips/tips/tips.component';
import { EventsComponent } from './pages/events/events/events.component';
import { EventComponent } from './pages/events/event/event.component';
import { AddEventComponent } from './pages/events/add-event/add-event.component';
import { EjemploComponent } from './pages/ejemplo/ejemplo.component';


@NgModule({
  declarations: [
    AddInstituteComponent,
    AddReportComponent,
    AsignarReportComponent,
    ChatComponent,
    ChatContainerComponent,
    ErrorPageComponent,
    EstadisticasComponent,
    GraficaCategoriesComponent,
    GraficaStatusComponent,
    HomeComponent,
    ImagePipe,
    InstituteComponent,
    InstitutesComponent,
    MyReportEditComponent,
    MyReportsComponent,
    MyReportsPendientesComponent,
    NavbarComponent,
    ReportComponent,
    ReportsComponent,
    ReportsPendientesComponent,
    StatisticsComponent,
    NewsComponent,
    NewComponent,
    AddNewComponent,
    AddTipComponent,
    TipComponent,
    TipsComponent,
    EventsComponent,
    EventComponent,
    AddEventComponent,
    EjemploComponent,
  ],
  imports: [
    ChartsModule,
    CommonModule,
    DashboardRoutingModule,
    FormsModule,
    ReactiveFormsModule,
  ]
})
export class DashboardModule { }
