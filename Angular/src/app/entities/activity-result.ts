import {IActivity} from './activity';
import {IActivityGroupResult} from './activity-group-result';
import {IPersonFull} from './person-full';
import {IEvent} from './event';
import {IActivityGroup} from './activity-group';

export interface IActivityResult {
  id?: number;
  primaryResultValue?: number;
  secondaryResultValue?: number;
  note?: string;
  
  testResultId?: number;
  activityId?: number;
  activityName?: number;

  eventDate?: string;

}

export class ActivityResult implements IActivityResult {
  id: number;
  primaryResultValue: number;
  secondaryResultValue: number;
  note: string;

  testResultId: number;
  activityId: number;
  activityName: number;

  eventDate: string;


  constructor(activity: IActivity) {
    this.activityId = activity.id;
  }
}
