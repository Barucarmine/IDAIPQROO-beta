import { Component, OnInit } from '@angular/core';
import { Service } from '../../../models/service.model';
import { AuthService } from '../../../auth/services/auth.service';
import { ReportsReponse } from '../../interfaces/reports_response.interface';
import { ReportsService } from '../../services/reports.service';

@Component({
  selector: 'app-my-reports',
  templateUrl: './my-reports.component.html',
  styleUrls: ['./my-reports.component.css']
})
export class MyReportsComponent implements OnInit {

  status: 'FINALIZED' | 'CANCELLED' | string = 'FINALIZED';
  isLoading: boolean = false;
  services: Service[] = [];


  constructor( private authService: AuthService,
              private reportsService: ReportsService) { }

  ngOnInit(): void {
    this.getReports( this.status )
  }


  getReports( status: string ){
    this.isLoading = true;
    this.reportsService.getMyReportsPendientes( this.authService.user.institute!, status)
    .subscribe( (resp: any) => {
      this.services = resp.services
      this.isLoading = false;
    });
  }


  changeStatus( value: 'FINALIZED' | 'CANCELLED'  | string ) {
    if ( value.length == 0 ) {
      return;
    }
    this.status = value;
    this.getReports(value);
  }

}
