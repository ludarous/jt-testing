import {Component, Input, OnInit, ViewEncapsulation} from '@angular/core';
import {IWorkout} from '../../../../entities/workout';
import {IEvent} from '../../../../entities/event';
import {IPersonFull} from '../../../../entities/person-full';
import {IWorkoutResult} from '../../../../entities/workout-result';
import {IEventResult} from '../../../../entities/event-result';
import {IActivityResult} from '../../../../entities/activity-result';
import {IActivity} from '../../../../entities/activity';

@Component({
  selector: 'app-workout-result-edit',
  templateUrl: './workout-result-edit.component.html',
  styleUrls: ['./workout-result-edit.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class WorkoutResultEditComponent implements OnInit {

  constructor() { }

  private _workout: IWorkout;
  @Input()
  get workout(): IWorkout {
    return this._workout;
  }

  set workout(value: IWorkout) {
    this._workout = value;
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
    console.log(this.testEvent);
  }

  getActivityForActivityResult(activityResult: IActivityResult): IActivity {
    return this.workout.activities.find(a => a.id === activityResult.activityId);
  }

}
