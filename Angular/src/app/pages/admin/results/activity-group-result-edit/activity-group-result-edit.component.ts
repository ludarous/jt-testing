import {Component, Input, OnInit, ViewEncapsulation} from '@angular/core';
import {IActivityGroup} from '../../../../entities/activity-group';
import {IEvent} from '../../../../entities/event';
import {IPersonFull} from '../../../../entities/person-full';
import {IActivityGroupResult} from '../../../../entities/activity-group-result';
import {IEventResult} from '../../../../entities/event-result';
import {IActivityResult} from '../../../../entities/activity-result';
import {IActivity} from '../../../../entities/activity';

@Component({
  selector: 'app-activity-group-result-edit',
  templateUrl: './activity-group-result-edit.component.html',
  styleUrls: ['./activity-group-result-edit.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class ActivityGroupResultEditComponent implements OnInit {

  constructor() { }

  private _activityGroup: IActivityGroup;
  @Input()
  get activityGroup(): IActivityGroup {
    return this._activityGroup;
  }

  set activityGroup(value: IActivityGroup) {
    this._activityGroup = value;
  }

  private _activityGroupResult: IActivityGroupResult;
  @Input()
  get activityGroupResult(): IActivityGroupResult {
    return this._activityGroupResult;
  }

  set activityGroupResult(value: IActivityGroupResult) {
    this._activityGroupResult = value;
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
    return this.activityGroup.activities.find(a => a.id === activityResult.activityId);
  }

}
