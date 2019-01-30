import {Component, Input, OnInit} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {IEvent} from '../../../../entities/event';
import {EventService} from '../../../../services/event.service';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {IPerson} from '../../../../entities/person';
import {IPersonFull} from '../../../../entities/person-full';
import {EventResult, IEventResult} from '../../../../entities/event-result';
import {EventResultService} from '../../../../services/event-result.service';
import {IActivityGroupResult} from '../../../../entities/activity-group-result';
import {IActivityGroup} from '../../../../entities/activity-group';
import {EventManager} from '../../../../services/event.manager';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-event-result-edit',
  templateUrl: './event-result-edit.component.html',
  styleUrls: ['./event-result-edit.component.scss']
})
export class EventResultEditComponent implements OnInit {



  private _person: IPersonFull;

  @Input()
  get person(): IPersonFull {
    return this._person;
  }

  set person(value: IPersonFull) {
    this._person = value;
  }

  private _testEvent: IEvent;

  @Input()
  get testEvent(): IEvent {
    return this._testEvent;
  }

  set testEvent(value: IEvent) {
    this._testEvent = value;
  }

  private _eventResult: IEventResult;
  @Input()
  get eventResult(): IEventResult {
    return this._eventResult;
  }

  set eventResult(value: IEventResult) {
    this._eventResult = value;
  }



  constructor(private activatedRoute: ActivatedRoute,
              private eventService: EventService,
              private eventManager: EventManager,
              private eventResultService: EventResultService,
              private messageService: MessageService,
              private router: Router) { }

  ngOnInit() {
    console.log(this._person);
  }

  getTestForTestResult(testResult: IActivityGroupResult): IActivityGroup {
    if (this.testEvent.tests) {
      return this.testEvent.tests.find((t) => t.id === testResult.testId);
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

}
