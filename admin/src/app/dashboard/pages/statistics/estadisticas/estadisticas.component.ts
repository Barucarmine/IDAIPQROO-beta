import { Component, OnInit } from '@angular/core';
import { MunicipalitiesService } from '../../../services/municipalities.service';

@Component({
  selector: 'app-estadisticas',
  templateUrl: './estadisticas.component.html',
  styleUrls: ['./estadisticas.component.css']
})
export class EstadisticasComponent implements OnInit {

  municipios: string [] = [];

  constructor( private municipalitiesService: MunicipalitiesService ) { }

  ngOnInit(): void {
    this.municipalitiesService.getMunicipalities()
        .subscribe( resp => {
          this.municipios = resp
        })
    
  }

}
