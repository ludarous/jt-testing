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
  
  activityGroupResultId?: number;
  activityId?: number;
  activityName?: number;

  date?: string;

}

export class ActivityResult implements IActivityResult {
  id: number;
  primaryResultValue: number;
  secondaryResultValue: number;
  note: string;

  activityGroupResultId: number;
  activityId: number;
  activityName: number;

  date: string;


  constructor(activity: IActivity) {
    this.activityId = activity.id;
  }
}
