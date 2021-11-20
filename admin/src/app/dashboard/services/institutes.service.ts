import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { map } from 'rxjs/operators';
import { InstitutesResponse } from '../interfaces/institutes_response.interface';
import { Institute } from 'src/app/models/institute.model';
import { InstituteForm } from '../interfaces/institute_form.interface';
import { InstituteUserForm } from '../interfaces/institute_user_form.interface';

const base_url = '';

@Injectable({
  providedIn: 'root'
})
export class InstitutesService {

  constructor( private http: HttpClient ) { }


  getAllByMunicipality( municipality: string ){
    return this.http.get<InstitutesResponse>(`${base_url}/institute/all/${ municipality }`)
      .pipe(
        map(  resp => {
          const institutes = resp.institutes.map(
            institute => new Institute(
              institute.manager,
              institute.name,
              institute.description,
              institute.municipality,
              institute.adress,
              institute.image,
              institute.siglas,
              institute._id,
            )
          );
          return institutes;
        })
      );
  }


  getById( id: string ) {
    return this.http.get(`${base_url}/institute/id/${ id }`)
  }


  getAll( ) {
    return this.http.get(`${base_url}/institute/all`)
  }



  create( form: InstituteForm ) {
    return this.http.post(`${base_url}/institute/create`, form )
    .pipe(
        map(  (resp: any) => resp.institute )
      );
  }


  adduser( form: InstituteUserForm ) {
    return this.http.post(`${base_url}/auth/register`, form )
  }

}
