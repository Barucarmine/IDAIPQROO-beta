import { Component, OnInit } from '@angular/core';
import { Tip } from '../../../../models/tip.model';
import { TipsService } from '../../../services/tips.service';
import { MunicipalitiesService } from '../../../services/municipalities.service';

@Component({
  selector: 'app-tips',
  templateUrl: './tips.component.html',
  styleUrls: ['./tips.component.css']
})
export class TipsComponent implements OnInit {

  municipalities: string[] = [];
  tips: Tip[] = [];
  isLoading: boolean = false;
  municipalitySeleccted: boolean = false;

  constructor( private tipsService: TipsService,
    private municipalitiesService:  
    MunicipalitiesService) { }

  ngOnInit(): void {
    this.municipalitiesService.getMunicipalities()
      .subscribe( resp => {
        this.municipalities = resp;
      })
    // this.getReports();
  }


  getReports( municipality: string ) {
    this.isLoading = true;
    this.tipsService.getAllByMunicipality(municipality)
      .subscribe( tips =>{
        this.tips = tips;
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
