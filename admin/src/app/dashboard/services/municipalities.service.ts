import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { map } from 'rxjs/operators';
import { Report } from '../../models/report.model';
import { ReportsReponse } from '../interfaces/reports_response.interface';
import { ServicesReponse } from '../interfaces/services_response.interface';
import { Service } from '../../models/service.model';

const base_url = '';

@Injectable({
  providedIn: 'root'
})
export class MunicipalitiesService {

  constructor( private http: HttpClient ) { }


  getMunicipalities(){
    return this.http.get(`${base_url}/municipality/all`)
      .pipe(
        map(  (resp: any) => {
          return resp.municipalities;
        })
      );
  }



  getColonias( municipio: string ) {
    return this.http.get(`${base_url}/municipality/colonies/${ municipio }`)
  }




}
