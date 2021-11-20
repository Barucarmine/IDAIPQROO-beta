import { Component, OnInit, Input } from '@angular/core';
import { ChartType, ChartOptions } from 'chart.js';
import { Label } from 'ng2-charts';
import { ReportsService } from '../../services/reports.service';

@Component({
  selector: 'app-grafica-categories',
  templateUrl: './grafica-categories.component.html',
  styleUrls: ['./grafica-categories.component.css']
})
export class GraficaCategoriesComponent implements OnInit {

  @Input() nombreMunicipio: string | undefined;

  public pieChartOptions = {};
  public pieChartLabels: Label[] = [];
  public pieChartData: number[] = [];
  public pieChartType: ChartType = 'pie';
  public pieChartLegend = true;
  // public pieChartPlugins = [pluginDataLabels];
  public pieChartColors = [{}];

  totalReports: number = 0;

  constructor( private reportsService: ReportsService ) { }

  ngOnInit(): void {
    
      this.reportsService.getEstadisticasPorMunicipio( this.nombreMunicipio! )  
        .subscribe( (resp: any) => {
          this.totalReports = resp.total
          this.crearGrafica(
            resp.vialidad,
            resp.salud_publica,
            resp.buena_vecindad,
            resp.atencion_ciudadana,
            resp.otro
          )
        })
   
      
  }


  crearGrafica( 
    vialidad: number,
    salud_publica: number,
    buena_vecindad: number,
    atencion_ciudadana: number,
    otro: number) {
    this.pieChartOptions = {
      responsive: true,
      legend: {
        position: 'left',
      },
    };
    this.pieChartLabels = ['Vialidad', 'Salud pública', 'Buena vecindad', 'Atención ciudadana', 'Otro'];
    this.pieChartData = [ vialidad, salud_publica, buena_vecindad, atencion_ciudadana, otro];
    this.pieChartType = 'pie';
    this.pieChartLegend = true;
    // public pieChartPlugins = [pluginDataLabels];
    this.pieChartColors = [
      {
        backgroundColor: ['rgb(250, 99, 97)', 'rgb(88, 80, 141)', 'rgb(14, 246, 191)', 'rgb(245, 137, 191)', 'rgb(196, 108, 240)'],
      },
    ];
    
  }
}