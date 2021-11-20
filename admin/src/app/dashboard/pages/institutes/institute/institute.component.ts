import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ChartType, ChartOptions } from 'chart.js';
import { Label } from 'ng2-charts';
import { InstitutesService } from 'src/app/dashboard/services/institutes.service';
// import * as pluginDataLabels from 'chartjs-plugin-datalabels';
import { Institute } from '../../../../models/institute.model';

@Component({
  selector: 'app-institute',
  templateUrl: './institute.component.html',
  styleUrls: ['./institute.component.css']
})
export class InstituteComponent implements OnInit {

  public pieChartOptions = {};
  public pieChartLabels: Label[] = [];
  public pieChartData: number[] = [];
  public pieChartType: ChartType = 'pie';
  public pieChartLegend = true;
  // public pieChartPlugins = [pluginDataLabels];
  public pieChartColors = [{}];

  institute!: Institute;
  totalReports: number = 0;

  constructor( private activatedRoute: ActivatedRoute,
               private institutesService: InstitutesService ) { }

  ngOnInit(): void {
    this.activatedRoute.params.subscribe( ({id}) => {

      this.institutesService.getById(id)  
        .subscribe( (resp: any) => {
          this.institute = resp.institute
          console.log(this.institute)
          this.totalReports = resp.total
          this.crearGrafica(resp.proceso, resp.finalizados, resp.cancelados)
        })
    })

  }


  crearGrafica( proceso: number, finalizados: number, cancelados: number) {
    this.pieChartOptions = {
      responsive: true,
      legend: {
        position: 'left',
      },
    };
    this.pieChartLabels = ['En proceso', 'Finalizado', 'Cancelado'];
    this.pieChartData = [ proceso, finalizados, cancelados];
    this.pieChartType = 'pie';
    this.pieChartLegend = true;
    // public pieChartPlugins = [pluginDataLabels];
    this.pieChartColors = [
      {
        backgroundColor: ['rgb(255, 222, 38)', 'rgb(48, 211, 86)', 'rgb(237, 35, 52)'],
      },
    ];
  }



}
