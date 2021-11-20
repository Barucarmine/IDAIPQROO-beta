import { Component, OnInit } from '@angular/core';
import { ReportsService } from '../../services/reports.service';
import { AuthService } from '../../../auth/services/auth.service';
import { Service } from '../../../models/service.model';

@Component({
  selector: 'app-my-reports-pendientes',
  templateUrl: './my-reports-pendientes.component.html',
  styleUrls: ['./my-reports-pendientes.component.css']
})
export class MyReportsPendientesComponent implements OnInit {

  services: Service[] = [];

  constructor( private  resportService: ReportsService,
              private authService: AuthService) { }

  ngOnInit(): void {
    this.resportService.getMyReportsPendientes( this.authService.user.institute!, 'PROCESS' )
      .subscribe( (resp: any) => {
        this.services = resp.services
      })
  }

}
