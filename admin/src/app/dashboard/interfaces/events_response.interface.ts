import { Event } from '../../models/event.model';


export interface EventsResponse {

    status: boolean;
    events: Event[];

}