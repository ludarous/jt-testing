import {Component, Input, OnInit} from '@angular/core';
import {EventResult, IEventResult} from '../../../../entities/event-result';
import {IEvent} from '../../../../entities/event';
import {IActivityGroupResult} from '../../../../entities/activity-group-result';
import {IActivityGroup} from '../../../../entities/activity-group';
import {EventResultService} from '../../../../services/event-result.service';
import {EventService} from '../../../../services/event.service';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';

@Component({
  selector: 'app-user-event-result',
  templateUrl: './user-event-result.component.html',
  styleUrls: ['./user-event-result.component.scss']
})
export class UserEventResultComponent implements OnInit {

  constructor(private eventResultService: EventResultService,
              private eventService: EventService) { }

  eventResults: Array<IEventResult>;

  @Input()
  event: IEvent;

  ngOnInit() {
    this.eventService.queryMyEventResults(this.event.id).subscribe((eventResultsResponse: HttpResponse<Array<EventResult>>) => {
      this.eventResults = eventResultsResponse.body;
    });
  }

  getActivityGroupForActivityGroupResult(activityGroupResult: IActivityGroupResult): IActivityGroup {
    return this.event.activityGroups.find((t) => t.id === activityGroupResult.id);
  }

}
