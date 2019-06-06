import {Component, Input, OnInit} from '@angular/core';
import {EventResult, IEventResult} from '../../../../../entities/event-result';
import {IEvent} from '../../../../../entities/event';
import {IWorkoutResult} from '../../../../../entities/workout-result';
import {IWorkout} from '../../../../../entities/workout';
import {EventResultService} from '../../../../../services/event-result.service';
import {EventService} from '../../../../../services/event.service';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { flatMap, map } from 'rxjs/operators';
import { zip } from 'rxjs';

@Component({
  selector: 'ngx-user-event-result',
  templateUrl: './user-event-result.component.html',
  styleUrls: ['./user-event-result.component.scss']
})
export class UserEventResultComponent implements OnInit {

  constructor(private activatedRoute: ActivatedRoute,
              private eventResultService: EventResultService,
              private eventService: EventService) { }

  eventResults: Array<IEventResult>;
  event: IEvent;

  ngOnInit() {
    const params$ = this.activatedRoute.params;

    const getData$ = params$
      .pipe(map((params) => {
      const eventId = +params['id'];
      return eventId;
    }))
      .pipe(flatMap((eventId) => {
        const event$ = this.eventService.find(eventId);
        const eventResults$ = this.eventService.queryMyEventResults(eventId);

        return zip(event$, eventResults$);
      }));

    getData$.subscribe(([event, eventResults]) => {
      this.event = event.body;
      this.eventResults = eventResults.body;
    });

  }

  getWorkoutForWorkoutResult(workoutResult: IWorkoutResult): IWorkout {
    return this.event.workouts.find((t) => t.id === workoutResult.id);
  }

}
