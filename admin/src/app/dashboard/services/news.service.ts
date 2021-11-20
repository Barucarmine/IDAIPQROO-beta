import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { map } from 'rxjs/operators';
import { HttpClient } from '@angular/common/http';
import { NewsResponse } from '../interfaces/news_response.interface';
import { Novedad } from '../../models/novedad.model';
import { NewForm } from '../interfaces/new_form.interface';




const base_url = '';


@Injectable({
  providedIn: 'root'
})
export class NewsService {

  constructor( private http: HttpClient ) { }

  getById( id: string ) {
    return this.http.get(`${base_url}/new/id/${ id }`)
  }

  getAll(){
    return this.http.get<NewsResponse>(`${base_url}/new/all`)
  }

  create( form: NewForm ) {
    return this.http.post(`${base_url}/new/create`, form )
    .pipe(
        map(  (resp: any) => resp.new )
      );
  }

}
