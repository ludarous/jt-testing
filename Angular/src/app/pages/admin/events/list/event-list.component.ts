import { Component, OnInit } from '@angular/core';
import {HttpResponse} from '@angular/common/http';
import {IActivity} from '../../../../entities/activity';
import {Router} from '@angular/router';
import {TestService} from '../../../../services/test.service';
import {ITest} from '../../../../entities/test';
import {IEvent} from '../../../../entities/event';
import {EventService} from '../../../../services/event.service';

@Component({
  selector: 'app-tests-list',
  templateUrl: './event-list.component.html',
  styleUrls: ['./event-list.component.scss']
})
export class EventListComponent implements OnInit {

  tableCols: Array<any>;
  events: Array<IEvent>;

  constructor(private eventService: EventService,
              private router: Router) { }

  ngOnInit() {

    this.tableCols = [
      { field: 'name', header: 'Název' },
    ];

    this.eventService.query().subscribe((eventsResponse: HttpResponse<Array<ITest>>) => {
      this.events = eventsResponse.body;
    });
  }

  rowSelect(event: IEvent) {
    this.router.navigate(['/admin/events/edit', event.id]);
  }
}
