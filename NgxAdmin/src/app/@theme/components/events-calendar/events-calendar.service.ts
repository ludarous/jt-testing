import { Injectable } from '@angular/core';
import {NbDateService} from '@nebular/theme';
import {EventService} from '../../../services/event.service';
import {IEvent, Event} from '../../../entities/event';
import {HttpResponse} from '@angular/common/http';
import {Subject} from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class EventsCalendarService {

  constructor(private dateService: NbDateService<Date>,
              private eventService: EventService) {

  }

  private eventsLoadedSource = new Subject<Array<IEvent>>();
  public eventsLoaded$ = this.eventsLoadedSource.asObservable();

  events: Array<IEvent>;
  eventRouterLink: (event) => any[];

  static isSameDay(date1: Date, date2: Date) {
    return (date1.getDate() === date2.getDate()
      && date1.getMonth() === date2.getMonth()
      && date1.getFullYear() === date2.getFullYear());
  }

  loadEvents() {
    this.eventService.query().subscribe((eventsResponse: HttpResponse<Array<IEvent>>) => {
      this.events = Event.resolveArrayResponse(eventsResponse);
      this.eventsLoadedSource.next(this.events);
    });
  }

}
