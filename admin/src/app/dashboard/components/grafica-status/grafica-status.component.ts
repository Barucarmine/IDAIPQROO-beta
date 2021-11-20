import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ChartType, ChartOptions } from 'chart.js';
import { Label } from 'ng2-charts';
// import * as pluginDataLabels from 'chartjs-plugin-datalabels';
import { InstitutesService } from '../../services/institutes.service';
import { Institute } from '../../../models/institute.model';


@Component({
  selector: 'app-grafica-status',
  templateUrl: './grafica-status.component.html',
  styleUrls: ['./grafica-status.component.css']
})
export class GraficaStatusComponent implements OnInit {

  @Input() idInstitute: string | undefined;
  institute!: Institute;
  
  public pieChartOptions = {};
  public pieChartLabels: Label[] = [];
  public pieChartData: number[] = [];
  public pieChartType: ChartType = 'pie';
  public pieChartLegend = true;
  // public pieChartPlugins = [pluginDataLabels];
  public pieChartColors = [{}];

  totalReports: number = 0;

  constructor( private institutesService: InstitutesService ) { }

  ngOnInit(): void {
    
      this.institutesService.getById( this.idInstitute! )  
        .subscribe( (resp: any) => {
          this.institute = resp.institute
          console.log(this.institute)
          this.totalReports = resp.total
          this.crearGrafica(resp.proceso, resp.finalizados, resp.cancelados)
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
