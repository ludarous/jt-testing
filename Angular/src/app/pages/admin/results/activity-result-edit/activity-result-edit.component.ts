import {Component, Input, OnInit} from '@angular/core';
import {IActivity} from '../../../../entities/activity';
import {ActivityResult, IActivityResult} from '../../../../entities/activity-result';
import {IWorkoutResult} from '../../../../entities/workout-result';
import {FormControl, FormGroup} from '@angular/forms';
import {IEvent} from '../../../../entities/event';

@Component({
  selector: 'app-activity-result-edit',
  templateUrl: './activity-result-edit.component.html',
  styleUrls: ['./activity-result-edit.component.scss']
})
export class ActivityResultEditComponent implements OnInit {

  constructor() { }

  private _activity: IActivity;
  @Input()
  get activity(): IActivity {
    return this._activity;
  }

  set activity(value: IActivity) {
    this._activity = value;
  }

  private _activityResult: IActivityResult;
  @Input()
  get activityResult(): IActivityResult {
    return this._activityResult;
  }

  set activityResult(value: IActivityResult) {
    if (value) {
      this._activityResult = value;
      //this.setActivityResultForm(this._activityResult);
    }
  }

  private _workoutResult: IWorkoutResult;
  @Input()
  get workoutResult(): IWorkoutResult {
    return this._workoutResult;
  }

  set workoutResult(value: IWorkoutResult) {
    this._workoutResult = value;
  }

  private _testEvent: IEvent;
  @Input()
  get testEvent(): IEvent {
    return this._testEvent;
  }

  set testEvent(value: IEvent) {
    this._testEvent = value;
  }

  activityResultForm: FormGroup;

  ngOnInit() {
    // if (!this.activityResult) this.activityResult = new ActivityResult();
    if (this.activityResult) {
      this.setActivityResultForm(this.activityResult);
    }
  }

  setActivityResultForm(activityResult: IActivityResult) {
    this.activityResultForm = new FormGroup({
      id: new FormControl(activityResult.id),
      note: new FormControl(activityResult.note),
      primaryResultValue: new FormControl(activityResult.primaryResultValue),
      secondaryResultValue: new FormControl(activityResult.secondaryResultValue),
      workoutResultId: new FormControl(activityResult.workoutResultId),
      activityId: new FormControl(activityResult.activityId),
      eventDate: new FormControl(this.testEvent.date)
    });
  }

}
