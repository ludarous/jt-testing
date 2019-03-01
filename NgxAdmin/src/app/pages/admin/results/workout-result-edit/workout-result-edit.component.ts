import {Component, Input, OnInit, ViewChild, ViewEncapsulation} from '@angular/core';
import {IWorkout} from '../../../../entities/workout';
import {IEvent} from '../../../../entities/event';
import {IPersonFull} from '../../../../entities/person-full';
import {IWorkoutResult} from '../../../../entities/workout-result';
import {IEventResult} from '../../../../entities/event-result';
import {IActivityResult} from '../../../../entities/activity-result';
import {IActivity} from '../../../../entities/activity';
import {NbStepperComponent} from '@nebular/theme';

@Component({
  selector: 'ngx-workout-result-edit',
  templateUrl: './workout-result-edit.component.html',
  styleUrls: ['./workout-result-edit.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class WorkoutResultEditComponent implements OnInit {

  private selectedActivityResult: IActivityResult;

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

  private _event: IEvent;
  @Input()
  get event(): IEvent {
    return this._event;
  }

  set event(value: IEvent) {
    this._event = value;
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

  @ViewChild('stepper')
  stepper: NbStepperComponent;


  ngOnInit() {
    // console.log(this.event);
  }

  getActivityForActivityResult(activityResult: IActivityResult): IActivity {
    if (activityResult) {
      return this.workout.activities.find(a => a.id === activityResult.activityId);
    }

    return null;
  }

  onActivityResultSuccessSave(activityResults: IActivityResult) {
    if (this.stepper) this.stepper.next();
  }

  selectActivityResult(activityResult: IActivityResult) {
    this.selectedActivityResult = activityResult;
  }

}
