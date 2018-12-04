import {Component, Input, OnInit} from '@angular/core';
import {IEventResult} from '../../../../entities/event-result';
import {IEvent} from '../../../../entities/event';
import {ITestResult} from '../../../../entities/test-result';
import {ITest} from '../../../../entities/test';

@Component({
  selector: 'app-user-event-result',
  templateUrl: './user-event-result.component.html',
  styleUrls: ['./user-event-result.component.scss']
})
export class UserEventResultComponent implements OnInit {

  constructor() { }

  @Input()
  eventResults: Array<IEventResult>;

  @Input()
  event: IEvent;

  ngOnInit() {
  }

  getTestForTestResult(testResult: ITestResult): ITest {
    return this.event.tests.find((t) => t.id === testResult.testId);
  }

}
