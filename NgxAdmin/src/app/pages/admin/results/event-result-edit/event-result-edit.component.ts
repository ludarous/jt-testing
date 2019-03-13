import {Component, Input, OnInit} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {IEvent, Event} from '../../../../entities/event';
import {EventService} from '../../../../services/event.service';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {IPerson} from '../../../../entities/person';
import {IPersonFull} from '../../../../entities/person-full';
import {EventResult, IEventResult} from '../../../../entities/event-result';
import {EventResultService} from '../../../../services/event-result.service';
import {IWorkoutResult} from '../../../../entities/workout-result';
import {IWorkout} from '../../../../entities/workout';
import {EventManager} from '../../../../services/event.manager';
import {MessageService} from 'primeng/api';
import {PersonService} from '../../../../services/person.service';
import {zip} from 'rxjs';

@Component({
  selector: 'ngx-event-result-edit',
  templateUrl: './event-result-edit.component.html',
  styleUrls: ['./event-result-edit.component.scss']
})
export class EventResultEditComponent implements OnInit {

  eventId: number;
  event: IEvent;

  personId: number;
  person: IPersonFull;

  eventResult: IEventResult;

  constructor(private activatedRoute: ActivatedRoute,
              private eventService: EventService,
              private eventManager: EventManager,
              private eventResultService: EventResultService,
              private personService: PersonService,
              private messageService: MessageService,
              private router: Router) { }

  ngOnInit() {
    this.activatedRoute.params.subscribe((params) => {
      this.eventId = +params['eventId'];
      this.personId = +params['personId'];

      if (this.eventId && this.personId) {
        const event$ = this.eventService.find(this.eventId);
        const person$ = this.personService.findFull(this.personId);

        zip(event$, person$).subscribe(([eventResponse, personResponse]) => {
          this.event = Event.resolveResponse(eventResponse);
          this.person = personResponse.body;

          this.eventResult = this.event.eventResults.find(er => er.eventId === this.eventId && er.personId === this.personId);
          if (!this.eventResult) this.createEventResult();
        });
      }
    });
  }

  getWorkoutForWorkoutResult(workoutResult: IWorkoutResult): IWorkout {
    if (this.event.workouts) {
      return this.event.workouts.find((t) => t.id === workoutResult.workoutId);
    }
  }

  saveEventResults() {

    this.eventResultService
      .update(this.eventResult)
      .subscribe(
        (eventResultResponse: HttpResponse<IEventResult>) => {
        this.eventResult = eventResultResponse.body;
          this.messageService.add({severity: 'success', summary: 'Výsledky uloženy'});
          this.router.navigate(['/admin/results']);
      },
        (errorResponse: HttpErrorResponse) => {
          this.messageService.add({severity: 'error', summary: 'Výsledky nebyly uloženy', detail: errorResponse.error.detail});
        });
  }

  createEventResult() {

    const eventResult = new EventResult(this.event, this.person);

    this.eventResultService
      .create(eventResult)
      .subscribe((eventResultResponse: HttpResponse<IEventResult>) => {
        this.eventResult = eventResultResponse.body;
        this.eventManager.broadcast({
          name: 'eventResultCreated',
          content: this.eventResult
        });
      });
  }

}
