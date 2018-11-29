import { Component, OnInit } from '@angular/core';
import {FormControl, FormGroup} from '@angular/forms';
import { IActivity} from '../../../../entities/activity';
import {IActivityCategory} from '../../../../entities/activity-category';
import {ActivatedRoute} from '@angular/router';
import {HttpResponse} from '@angular/common/http';
import {Observable, zip} from 'rxjs';
import {map} from 'rxjs/operators';
import {RxjsUtils} from '../../../../utils/rxjs.utils';
import {ITest, Test} from '../../../../entities/test';
import {ISport} from '../../../../entities/sport';
import {TestService} from '../../../../services/test.service';
import {EventService} from '../../../../services/event.service';
import {IEvent, Event} from '../../../../entities/event';
import {IPersonFull} from '../../../../entities/person-full';
import {PersonService} from '../../../../services/person.service';
import {Person} from '../../../../entities/person';
import {Moment} from 'moment';
import * as moment from 'moment';

@Component({
  selector: 'app-events-edit',
  templateUrl: './event-edit.component.html',
  styleUrls: ['./event-edit.component.scss']
})
export class EventEditComponent implements OnInit {

  eventForm: FormGroup;
  event: IEvent;
  eventId: number;

  tests: Array<ITest>;
  persons: Array<IPersonFull>;

  selectedTests: Array<ITest>;
  selectedPersons: Array<IPersonFull>;


  private _eventDate: Moment;
  get eventDate(): Moment {
    return this._eventDate;
  }

  set eventDate(value: Moment) {
    this._eventDate = value;
  }

  get eventTime(): String {
    if (this.eventDate) {
      return this.eventDate.hour() + ':' + this.eventDate.minute();
    }
  }

  set eventTime(value: String) {
    const time = value.split(':');
    if (time && time.length === 2) {
      this.eventDate.hour(+time[0]);
      this.eventDate.minute(+time[1]);
    }
  }

  constructor(private activatedRoute: ActivatedRoute,
              private eventService: EventService,
              private personService: PersonService,
              private testService: TestService) { }

  ngOnInit() {

    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.eventId = +params['id'];

      const getTests$ = this.testService.query({
        page: 0,
        size: 1000,
      });
      const getPersons$ = this.personService.queryFull({
        page: 0,
        size: 1000,
      });
      const getEvent$ = this.getEvent(this.eventId);

      zip(getEvent$, getTests$, getPersons$).subscribe(([event, tests, persons]) => {
        this.event = event;
        this.tests = tests.body;
        this.persons = persons.body;
        this.eventDate = moment(this.event.date);
        
        this.setEventForm(this.event, this.tests, this.persons);
      });

    });
  }
  

  setEventForm(event: IEvent, tests: Array<ITest>, persons: Array<IPersonFull>) {

    this.eventForm = new FormGroup({
      id: new FormControl(event.id),
      name: new FormControl(event.name),
      date: new FormControl(event.date),
      minAge: new FormControl(event.minAge),
      maxAge: new FormControl(event.maxAge)
    });

    if (event.tests) {
      this.selectedTests = tests.filter((t) => event.tests.some((st) => st.id === t.id));
    }

    if (event.tests) {
      this.selectedPersons = persons.filter((p) => event.attachedPersons.some((sp) => sp.id === p.id));
    }
    
  }

  saveTest() {
    if (this.eventForm.valid) {

      const eventToSave = <IEvent>this.eventForm.value;
      eventToSave.date = this.eventDate.toISOString();
      let saveEvent$;
      if (eventToSave.id) {
        saveEvent$ = this.eventService.update(eventToSave);
      } else {
        saveEvent$ = this.eventService.create(eventToSave);
      }

      eventToSave.tests = this.selectedTests;
      eventToSave.attachedPersons = this.selectedPersons.map(pf => Person.createPerson(pf));

      saveEvent$.subscribe((eventResponse: HttpResponse<IEvent>) => {
        this.event = eventResponse.body;
        this.setEventForm(this.event, this.tests, this.persons);
      });
    }
  }

  getEvent(eventId: number): Observable<IEvent> {
    if (eventId) {
      return this.eventService.find(eventId).pipe(map((eventResponse: HttpResponse<IEvent>) => {
        return eventResponse.body;
      }));

    } else {
      return RxjsUtils.create(new Event());
    }
  }
}
