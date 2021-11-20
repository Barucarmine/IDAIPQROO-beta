import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';
import { TipsReponse } from '../interfaces/tips_response.interface';
import { Tip } from '../../models/tip.model';
import { TipForm } from '../interfaces/tip_form.interface';

const base_url = '';


@Injectable({
  providedIn: 'root'
})
export class TipsService {

  constructor( private http: HttpClient ) { }

  getAllByMunicipality( municipality: string){
    return this.http.get<TipsReponse>(`${base_url}/tip/all/${ municipality }`)
      .pipe(
        map(  resp => {
          const tips = resp.tips.map(
            tip => new Tip(
              tip.text,
              tip.descripcion,
              tip.image,
              tip.show,
              tip._id
            )
          );
          return tips;
        })
      );
  }

  getById( id: string ) {
    return this.http.get(`${base_url}/tip/id/${ id }`)
  }


  getAll( ) {
    return this.http.get(`${base_url}/tip/all`)
  }



  create( form: TipForm ) {
    return this.http.post(`${base_url}/tip/create`, form )
    .pipe(
        map(  (resp: any) => resp.tip )
      );
  }


}
