import { Component, OnInit } from '@angular/core';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {Router} from '@angular/router';
import {IWorkout} from '../../../../entities/workout';
import {IEvent} from '../../../../entities/event';
import {EventService} from '../../../../services/event.service';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'ngx-events-list',
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
    this.eventService.query().subscribe((eventsResponse: HttpResponse<Array<IEvent>>) => {
      this.events = eventsResponse.body;
    });
  }

  rowSelect(event: IEvent) {
    this.edit(event);
  }

  delete(event: IEvent) {
    if (confirm('Opravdu chceš smazat událost ' + event.name)) {
      this.eventService.delete(event.id).subscribe(() => {
        this.load();
      }, (errorResponse: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Událost se nepodařilo smazat', detail: errorResponse.error.detail});
      });
    }
  }

  edit(event: IEvent) {
    this.router.navigate(['/pages/admin/events/edit', event.id]);
  }


  create() {
    this.router.navigate(['/pages/admin/events/create']);
  }
}
