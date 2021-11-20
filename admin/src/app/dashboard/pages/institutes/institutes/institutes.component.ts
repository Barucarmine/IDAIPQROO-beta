import { Component, OnInit } from '@angular/core';
import { InstitutesService } from '../../../services/institutes.service';
import { Institute } from '../../../../models/institute.model';
import { MunicipalitiesService } from '../../../services/municipalities.service';

@Component({
  selector: 'app-institutes',
  templateUrl: './institutes.component.html',
  styleUrls: ['./institutes.component.css']
})
export class InstitutesComponent implements OnInit {

  municipalities: string[] = [];
  institutes: Institute[] = [];
  isLoading: boolean = false;
  municipalitySeleccted: boolean = false;

  constructor( private institutesService: InstitutesService,
               private municipalitiesService: MunicipalitiesService) { }

  ngOnInit(): void {
    this.municipalitiesService.getMunicipalities()
      .subscribe( resp => {
        this.municipalities = resp;
      })
    // this.getReports();
  }


  getReports( municipality: string ) {
    this.isLoading = true;
    this.institutesService.getAllByMunicipality(municipality)
      .subscribe( institutes =>{
        this.institutes = institutes;
        this.isLoading = false;
      })
  }

  changeMunicipality( value: string ) {

    if ( value.length == 0 ) {
      this.municipalitySeleccted = false;
      return;
    }
    this.municipalitySeleccted = true;
    this.getReports(value);
  }

}
