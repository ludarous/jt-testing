import { Component, OnInit } from '@angular/core';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {IActivity} from '../../../../entities/activity';
import {Router} from '@angular/router';
import {WorkoutService} from '../../../../services/workout.service';
import {IWorkout} from '../../../../entities/workout';
import {IEvent} from '../../../../entities/event';
import {EventService} from '../../../../services/event.service';
import {IActivityCategory} from '../../../../entities/activity-category';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-tests-list',
  templateUrl: './event-list.component.html',
  styleUrls: ['./event-list.component.scss']
})
export class EventListComponent implements OnInit {

  tableCols: Array<any>;
  events: Array<IEvent>;

  constructor(private eventService: EventService,
              private router: Router,
              private messageService: MessageService) { }

  ngOnInit() {

    this.tableCols = [
      { field: 'name', header: 'Název' },
    ];

    this.load();
  }

  load() {
    this.eventService.query().subscribe((eventsResponse: HttpResponse<Array<IWorkout>>) => {
      this.events = eventsResponse.body;
    });
  }

  rowSelect(event: IEvent) {
    this.router.navigate(['/admin/events/edit', event.id]);
  }

  delete(event, testEvent: IEvent) {
    event.stopPropagation();

    if (confirm('Opravdu chceš smazat událost ' + testEvent.name)) {
      this.eventService.delete(testEvent.id).subscribe(() => {
        this.load();
      }, (errorResponse: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Událost se nepodařilo smazat', detail: errorResponse.error.detail});
      });
    }

  }
}
