import { Component, OnInit } from '@angular/core';
import {EventService} from '../../services/event.service';
import {EventResultService} from '../../services/event-result.service';
import {HttpResponse} from '@angular/common/http';
import {IEventResult} from '../../entities/event-result';

@Component({
  selector: 'app-user-results',
  templateUrl: './user-results.component.html',
  styleUrls: ['./user-results.component.scss']
})
export class UserResultsComponent implements OnInit {

  constructor(private eventResultService: EventResultService) { }

  myEventResults: Array<IEventResult>;

  ngOnInit() {
    const getEventResults$ = this.eventResultService.queryMyEventResults();
    getEventResults$.subscribe((myEventResultsResponse: HttpResponse<Array<IEventResult>>) => {
      this.myEventResults = myEventResultsResponse.body;
    });
  }

}
