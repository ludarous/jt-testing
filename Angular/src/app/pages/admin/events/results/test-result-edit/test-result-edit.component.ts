import {Component, Input, OnInit} from '@angular/core';
import {ITest} from '../../../../../entities/test';
import {IEvent} from '../../../../../entities/event';
import {IPersonFull} from '../../../../../entities/person-full';
import {ITestResult, TestResult} from '../../../../../entities/test-result';
import {IEventResult} from '../../../../../entities/event-result';

@Component({
  selector: 'app-test-result-edit',
  templateUrl: './test-result-edit.component.html',
  styleUrls: ['./test-result-edit.component.scss']
})
export class TestResultEditComponent implements OnInit {

  constructor() { }

  @Input()
  test: ITest;

  @Input()
  testsResult: ITestResult;

  @Input()
  event: IEvent;

  @Input()
  eventResult: IEventResult;

  @Input()
  person: IPersonFull;



  ngOnInit() {

  }

}
