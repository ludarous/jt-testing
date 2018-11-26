import {Component, Input, OnInit} from '@angular/core';
import {ITest} from '../../../../../entities/test';
import {IEvent} from '../../../../../entities/event';
import {IPersonFull} from '../../../../../entities/person-full';
import {ITestResult, TestResult} from '../../../../../entities/test-result';
import {IEventResult} from '../../../../../entities/event-result';
import {IActivityResult} from '../../../../../entities/activity-result';
import {IActivity} from '../../../../../entities/activity';

@Component({
  selector: 'app-test-result-edit',
  templateUrl: './test-result-edit.component.html',
  styleUrls: ['./test-result-edit.component.scss']
})
export class TestResultEditComponent implements OnInit {

  constructor() { }

  private _test: ITest;
  @Input()
  get test(): ITest {
    return this._test;
  }

  set test(value: ITest) {
    this._test = value;
  }

  private _testsResult: ITestResult;
  @Input()
  get testsResult(): ITestResult {
    return this._testsResult;
  }

  set testsResult(value: ITestResult) {
    this._testsResult = value;
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

  private _person: IPersonFull;
  @Input()
  get person(): IPersonFull {
    return this._person;
  }

  set person(value: IPersonFull) {
    this._person = value;
  }



  ngOnInit() {

  }

  getActivityForActivityResult(activityResult: IActivityResult): IActivity {
    return this.test.activities.find(a => a.id === activityResult.activityId);
  }

}
