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
  selectedTests: Array<ITest>;

  constructor(private activatedRoute: ActivatedRoute,
              private eventService: EventService,
              private testService: TestService) { }

  ngOnInit() {

    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.eventId = +params['id'];

      const getTests$ = this.testService.query();
      const getEvent$ = this.getEvent(this.eventId);

      zip(getEvent$, getTests$).subscribe(([event, tests]) => {
        this.event = event;
        this.tests = tests.body;
        
        this.setEventForm(this.event, this.tests);
      });

    });
  }
  

  setEventForm(event: IEvent, tests: Array<ITest>) {

    this.eventForm = new FormGroup({
      id: new FormControl(event.id),
      name: new FormControl(event.name),
      date: new FormControl(event.date),
    });

    if (event.tests) {
      this.selectedTests = tests.filter((t) => event.tests.some((st) => st.id === t.id));
    }
    
  }

  saveTest() {
    if (this.eventForm.valid) {

      const eventToSave = <IEvent>this.eventForm.value;
      let saveEvent$;
      if (eventToSave.id) {
        saveEvent$ = this.eventService.update(eventToSave);
      } else {
        saveEvent$ = this.eventService.create(eventToSave);
      }

      eventToSave.tests = this.selectedTests;

      saveEvent$.subscribe((eventResponse: HttpResponse<IEvent>) => {
        this.event = eventResponse.body;
        this.setEventForm(this.event, this.tests);
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
