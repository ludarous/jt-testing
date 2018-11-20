import {Component, Input, OnInit} from '@angular/core';
import {IActivity} from '../../../../../entities/activity';
import {ActivityResult, IActivityResult} from '../../../../../entities/activity-result';
import {ITestResult} from '../../../../../entities/test-result';
import {FormControl, FormGroup} from '@angular/forms';

@Component({
  selector: 'app-activity-result-edit',
  templateUrl: './activity-result-edit.component.html',
  styleUrls: ['./activity-result-edit.component.scss']
})
export class ActivityResultEditComponent implements OnInit {

  constructor() { }

  @Input()
  activity: IActivity;

  @Input()
  activityResult: IActivityResult;

  @Input()
  testResult: ITestResult;

  activityResultForm: FormGroup;

  ngOnInit() {
    if (!this.activityResult) this.activityResult = new ActivityResult();
    this.setActivityResultForm(this.activityResult);
  }

  setActivityResultForm(activityResult: IActivityResult) {
    this.activityResultForm = new FormGroup({
      id: new FormControl(activityResult.id),
      name: new FormControl(activityResult.note),
      primaryResultValue: new FormControl(activityResult.primaryResultValue),
      secondaryResultValue: new FormControl(activityResult.secondaryResultValue),
      testResultId: new FormControl(activityResult.testResultId),
      activityId: new FormControl(activityResult.activityId),
    });
  }

  saveActivityResult() {

  }

}
