import { Component, OnInit } from '@angular/core';
import {HttpResponse} from '@angular/common/http';
import {EventResultService} from '../../../services/event-result.service';
import {EventService} from '../../../services/event.service';
import {IEventResult} from '../../../entities/event-result';
import {IEvent, Event} from '../../../entities/event';

@Component({
  selector: 'app-user-results',
  templateUrl: './user-results.component.html',
  styleUrls: ['./user-results.component.scss']
})
export class UserResultsComponent implements OnInit {

  constructor(private eventResultService: EventResultService,
              private eventService: EventService) { }

  myEventResults: Array<IEventResult>;
  myEvents: Array<IEvent>;

  ngOnInit() {

    const getMyEvent$ = this.eventService.queryMyEvents();
    getMyEvent$.subscribe((myEventsResponse: HttpResponse<Array<IEvent>>) => {
      this.myEvents = Event.resolveArrayResponse(myEventsResponse);
    });
  }

}
