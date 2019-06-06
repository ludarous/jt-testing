import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup} from '@angular/forms';
import {ActivatedRoute, Router} from '@angular/router';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {Observable, zip} from 'rxjs';
import {map} from 'rxjs/operators';
import {IWorkout} from '../../../../entities/workout';
import {EventService} from '../../../../services/event.service';
import {Event, IEvent} from '../../../../entities/event';
import {IPersonFull} from '../../../../entities/person-full';
import {PersonService} from '../../../../services/person.service';
import {Person} from '../../../../entities/person';
import {Moment} from 'moment';
import {MessageService} from 'primeng/api';
import {WorkoutService} from '../../../../services/workout.service';
import {RxjsUtils} from '../../../../utils/rxjs.utils';

@Component({
  selector: 'app-events-edit',
  templateUrl: './event-edit.component.html',
  styleUrls: ['./event-edit.component.scss']
})
export class EventEditComponent implements OnInit {

  eventForm: FormGroup;
  event: IEvent;
  eventId: number;

  tests: Array<IWorkout>;
  persons: Array<IPersonFull>;

  suggestedTests: Array<IWorkout> = new Array<IWorkout>();
  suggestedPerson: Array<IPersonFull> = new Array<IPersonFull>();

  selectedTests: Array<IWorkout> = new Array<IWorkout>();
  selectedPersons: Array<IPersonFull> = new Array<IPersonFull>();


  private _eventDateClassic: Date;
  get eventDateClassic(): Date {
    return this._eventDateClassic;
  }

  set eventDateClassic(value: Date) {
    this._eventDateClassic = value;
    if (this.eventForm && value) {
      this.eventForm.controls['date'].setValue(value.toISOString());
    }
  }

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
              private workoutService: WorkoutService,
              private messageService: MessageService,
              private router: Router) { }

  ngOnInit() {

    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.eventId = +params['id'];

      const getTests$ = this.workoutService.query({
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

        this.setEventForm(this.event, this.tests, this.persons);
      });

    });
  }
  

  setEventForm(event: IEvent, tests: Array<IWorkout>, persons: Array<IPersonFull>) {

    this.eventForm = new FormGroup({
      id: new FormControl(event.id),
      name: new FormControl(event.name),
      date: new FormControl(event.date ? new Date(event.date) : null),
      minAge: new FormControl(event.minAge),
      maxAge: new FormControl(event.maxAge)
    });

    if (tests && event.workouts) {
      this.selectedTests = tests.filter((t) => event.workouts.some((st) => st.id === t.id));
      this.suggestedTests = tests.filter((t) => !this.selectedTests.some((st) => st.id === t.id));
    } else {
      this.suggestedTests = tests;
    }

    if (persons && event.attachedPersons) {
      this.selectedPersons = persons.filter((p) => event.attachedPersons.some((sp) => sp.id === p.id));
      this.suggestedPerson = persons.filter((p) => !this.selectedPersons.some((sp) => sp.id === p.id));
    } else {
      this.suggestedPerson = persons;
    }

    this.eventDateClassic = event.date ? new Date(event.date) : null;
    
  }

  duplicateEvent() {
    this.eventForm.controls['id'].setValue(null);
    const eventName = this.eventForm.controls['name'].value;
    this.eventForm.controls['name'].setValue(eventName + ' kopie');

    this.saveEvent();
  }

  saveEvent() {
    if (this.eventForm.valid) {

      const eventToSave = <IEvent>this.eventForm.value;

      let saveEvent$;
      if (eventToSave.id) {
        saveEvent$ = this.eventService.update(eventToSave);
      } else {
        saveEvent$ = this.eventService.create(eventToSave);
      }

      if (this.selectedTests) {
        eventToSave.workouts = this.selectedTests;
      }

      if (this.selectedPersons) {
        eventToSave.attachedPersons = this.selectedPersons.map(pf => Person.createPerson(pf));
      }

      saveEvent$.subscribe(
        (eventResponse: HttpResponse<IEvent>) => {
        this.event = eventResponse.body;
        this.setEventForm(this.event, this.tests, this.persons);
        this.messageService.add({severity: 'success', summary: 'Událost uložena'});
        this.router.navigate(['/admin/events/list']);
      },
        (errorResponse: HttpErrorResponse) => {
          this.messageService.add({severity: 'error', summary: 'Událost nebyla uložena', detail: errorResponse.error.detail});
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
