import { Component, OnInit } from '@angular/core';
import { EventsService } from '../../../services/events.service';
import { Event } from '../../../../models/event.model';
import { MunicipalitiesService } from '../../../services/municipalities.service';

@Component({
  selector: 'app-events',
  templateUrl: './events.component.html',
  styleUrls: ['./events.component.css']
})
export class EventsComponent implements OnInit {

  municipalities: string[] = [];
  events: Event[] = [];
  isLoading: boolean = false;
  municipalitySeleccted: boolean = false;

  constructor(private eventsService: EventsService,
    private municipalitiesService: MunicipalitiesService) { }

  ngOnInit(): void {
    this.municipalitiesService.getMunicipalities()
      .subscribe( resp => {
        this.municipalities = resp;
      })
  }

  getReports( municipality: string ) {
    this.isLoading = true;
    this.eventsService.getAllByMunicipality(municipality)
      .subscribe( events =>{
        this.events = events;
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
