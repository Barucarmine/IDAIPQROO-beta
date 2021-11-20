import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';
import { EventsResponse } from '../interfaces/events_response.interface';
import { Event } from '../../models/event.model';
import { EventForm } from '../interfaces/event_form.interface';


const base_url = '';

@Injectable({
  providedIn: 'root'
})
export class EventsService {

  constructor( private http: HttpClient ) { }

  getAllByMunicipality( municipality: string ){
    return this.http.get<EventsResponse>(`${base_url}/event/all/${ municipality }`)
      .pipe(
        map(  resp => {
          const events = resp.events.map(
            event => new Event(
              event.title,
              event.subtitle,
              event.description,
              event.municipality,
              event.direction,
              event.date,
              event.hour,
              event.image,
              event._id,
            )
          );
          return events;
        })
      );
  }


  getById( id: string ) {
    return this.http.get(`${base_url}/event/id/${ id }`)
  }


  getAll( ) {
    return this.http.get(`${base_url}/event/all`)
  }



  create( form: EventForm ) {
    return this.http.post(`${base_url}/event/create`, form )
    .pipe(
        map(  (resp: any) => resp.event )
      );
  }
}
