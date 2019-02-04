import {IActivity} from './activity';

export interface IActivityResult {
  id?: number;
  primaryResultValue?: number;
  secondaryResultValue?: number;
  note?: string;
  
  workoutResultId?: number;
  activityId?: number;
  activityName?: number;

  date?: string;

}

export class ActivityResult implements IActivityResult {
  id: number;
  primaryResultValue: number;
  secondaryResultValue: number;
  note: string;

  workoutResultId: number;
  activityId: number;
  activityName: number;

  date: string;


  constructor(activity: IActivity) {
    this.activityId = activity.id;
  }
}
