import {Component, Input, OnInit} from '@angular/core';
import {ITest} from '../../../../entities/test';
import {ITestResult} from '../../../../entities/test-result';
import {IActivityResult} from '../../../../entities/activity-result';
import {IActivity} from '../../../../entities/activity';

@Component({
  selector: 'app-user-test-result',
  templateUrl: './user-test-result.component.html',
  styleUrls: ['./user-test-result.component.scss']
})
export class UserTestResultComponent implements OnInit {

  constructor() { }

  @Input()
  test: ITest;

  @Input()
  testResult: ITestResult;

  ngOnInit() {
  }

  getActivityForActivityResult(activityResult: IActivityResult): IActivity {
    return this.test.activities.find((a) => a.id === activityResult.activityId);
  }

}
