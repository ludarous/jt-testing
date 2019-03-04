import {Component, EventEmitter, Input, OnInit} from '@angular/core';
import { EventsCalendarMonthCellComponent } from './month-cell/month-cell.component';
import {EventsCalendarDayCellComponent} from './day-cell/day-cell.component';
import {EventsCalendarService} from './events-calendar.service';
import {IEvent} from '../../../entities/event';
import {CalendarUtils} from '../../../@core/utils/calendar-utils';

@Component({
  selector: 'ngx-events-calendar',
  templateUrl: 'events-calendar.component.html',
  styleUrls: ['events-calendar.component.scss'],
  entryComponents: [EventsCalendarMonthCellComponent, EventsCalendarDayCellComponent],
})
export class EventsCalendarComponent implements OnInit {

  constructor(private eventsCalendarService: EventsCalendarService) {

  }

  select: EventEmitter<Date> = new EventEmitter();

  date = new Date();
  monthCellComponent = EventsCalendarMonthCellComponent;
  dayCellComponent = EventsCalendarDayCellComponent;

  @Input()
  events: Array<IEvent>;

  @Input()
  eventRouterLink: (e) => any[];

  ngOnInit(): void {

    this.eventsCalendarService.events = this.events;
    this.eventsCalendarService.eventRouterLink = this.eventRouterLink;

    // this.eventsCalendarService.eventsLoaded$.subscribe((events: Array<IEvent>) => {
    //   this.events = events;
    // });
    //
    // this.eventsCalendarService.loadEvents();
  }
}
