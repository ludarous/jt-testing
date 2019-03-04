import {ChangeDetectorRef, Component, EventEmitter, HostBinding, OnInit, ViewEncapsulation} from '@angular/core';
import {NbCalendarCell, NbCalendarDayCellComponent, NbDateService} from '@nebular/theme';
import {EventsCalendarService} from '../events-calendar.service';
import {IEvent} from '../../../../entities/event';
import {CalendarUtils} from '../../../../@core/utils/calendar-utils';
import {Router} from '@angular/router';

@Component({
  selector: 'ngx-day-cell',
  styleUrls: ['day-cell.component.scss'],
  templateUrl: 'day-cell.component.html'
})
export class EventsCalendarDayCellComponent extends NbCalendarDayCellComponent<Date> implements NbCalendarCell<Date, Date>, OnInit {


  constructor(dateService: NbDateService<Date>,
              private eventsCalendarService: EventsCalendarService,
              private router: Router,
              private ref: ChangeDetectorRef ) {
    super(dateService);
  }

  select: EventEmitter<Date> = new EventEmitter();
  dayEvents: Array<IEvent> = new Array<IEvent>();

  @HostBinding('class.flex-full') fullWidth = true;

  private _date: Date;
  get date(): Date {
    return this._date;
  }

  set date(value: Date) {
    if (value) {
      this._date = value;
      this.getDateEvents(this.eventsCalendarService.events);
    }
  }

  ngOnInit(): void {
    this.eventsCalendarService.eventsLoaded$.subscribe((events: Array<IEvent>) => {
      this.getDateEvents(events);
    });

    this.getDateEvents(this.eventsCalendarService.events);

  }

  get title() {
    if (this.dateService && this.date) {
      return this.dateService.getDate(this.date);
    }
  }

  getDateEvents(events: Array<IEvent>) {
    if (events && this.date) {
      const filteredEvents = events.filter(e => EventsCalendarService.isSameDay(CalendarUtils.dateStringToDate(e.date), this.date));
      if (filteredEvents.length > 0) {
        this.dayEvents = [...filteredEvents];
        console.log(this.dayEvents);
        this.ref.detectChanges();
      }
    }
  }

  selectEvent(event: IEvent) {
    this.router.navigate(this.eventsCalendarService.eventRouterLink(event));
  }

}
