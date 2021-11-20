import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment.prod';


const base_url = environment.base_url;

@Injectable({
  providedIn: 'root'
})
export class ChatService {

  constructor( private http: HttpClient ) { }


  getMessages( userId: string | undefined ){
    return this.http.get(`${ base_url }/message/${ userId }` )
  }
}
