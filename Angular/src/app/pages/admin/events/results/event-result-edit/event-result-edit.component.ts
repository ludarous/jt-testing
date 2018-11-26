import {Component, Input, OnInit} from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {IEvent} from '../../../../../entities/event';
import {EventService} from '../../../../../services/event.service';
import {HttpResponse} from '@angular/common/http';
import {IPerson} from '../../../../../entities/person';
import {IPersonFull} from '../../../../../entities/person-full';
import {EventResult, IEventResult} from '../../../../../entities/event-result';
import {EventResultService} from '../../../../../services/event-result.service';
import {ITestResult} from '../../../../../entities/test-result';
import {ITest} from '../../../../../entities/test';
import {EventManager} from '../../../../../services/event.manager';

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
              private eventResultService: EventResultService) { }

  ngOnInit() {
    console.log(this._person);
  }

  getTestForTestResult(testResult: ITestResult): ITest {
    if (this.testEvent.tests) {
      return this.testEvent.tests.find((t) => t.id === testResult.testId);
    }
  }

  createEventResult() {

    const eventResult = new EventResult(this.testEvent, this._person);

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

  saveEventResults() {

    this.eventResultService
      .update(this.eventResult)
      .subscribe((eventResultResponse: HttpResponse<IEventResult>) => {
        this.eventResult = eventResultResponse.body;
      });
  }

}
