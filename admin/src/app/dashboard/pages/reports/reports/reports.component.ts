import { Component, OnInit } from '@angular/core';
import { concatMap, tap } from 'rxjs/operators';
import { ReportsService } from 'src/app/dashboard/services/reports.service';
import { Service } from 'src/app/models/service.model';

@Component({
  selector: 'app-reports',
  templateUrl: './reports.component.html',
  styleUrls: ['./reports.component.css']
})
export class ReportsComponent implements OnInit {
  
  services: Service[] = [];
  categories: string[] = [];

  isLoading: boolean = false;
  hasCategories: boolean = false;

  status: 'FINALIZED' | 'CANCELLED' | 'PROCESS' | 'PENDING' | string = 'PROCESS';
  categorie: string | undefined;

  constructor( private reportsService: ReportsService) { }

  ngOnInit(): void {

    this.reportsService.getCategories()
      .pipe(
        tap( categories => {
          this.categories = categories
          this.categorie = this.categories[0]
        } ),
        concatMap( categories => this.reportsService.getByCategoryAndStatus(this.status, categories[0]) )
      ).subscribe( services =>{
        this.services = services;
        this.isLoading = false;
      })

    
  }


  getReports( status: string, categoria: string ){
    this.isLoading = true;
    console.log(status)
    console.log(categoria)
    this.reportsService.getByCategoryAndStatus(status,categoria)
    .subscribe( services => {
      this.services = services;
      this.isLoading = false;
    });
  }

  changeStatus( value: 'FINALIZED' | 'CANCELLED' | 'PROCESS' | 'PENDING' | string ) {
    if ( value.length == 0 ) {
      return;
    }
    this.status = value;
    this.getReports(value, this.categorie!);
  }

  changeCategory( value: string ) {

    if ( value.length == 0 ) {
      return;
    }
    this.categorie = value;
    this.getReports(this.status!, value);
  }

}
