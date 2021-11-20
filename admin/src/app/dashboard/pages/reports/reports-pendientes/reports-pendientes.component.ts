import { Component, OnInit } from '@angular/core';
import { ReportsService } from 'src/app/dashboard/services/reports.service';
import { Report } from 'src/app/models/report.model';

@Component({
  selector: 'app-reports-pendientes',
  templateUrl: './reports-pendientes.component.html',
  styleUrls: ['./reports-pendientes.component.css']
})
export class ReportsPendientesComponent implements OnInit {

  reports: Report[] = [];

  constructor( private reportsService: ReportsService  ) {
  }

  ngOnInit(): void {
    this.reportsService.getReportsNotAssigned()
        .subscribe( reports => {
          this.reports = reports;
        });
  }
  

}
