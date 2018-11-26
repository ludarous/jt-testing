import {IActivity} from './activity';
import {ITestResult} from './test-result';

export interface IActivityResult {
  id?: number;
  primaryResultValue?: number;
  secondaryResultValue?: number;
  note?: string;
  
  testResultId?: number;
  activityId?: number;
  activityName?: number;
}

export class ActivityResult implements IActivityResult {
  id: number;
  primaryResultValue: number;
  secondaryResultValue: number;
  note: string;

  testResultId: number;
  activityId: number;
  activityName: number;

  constructor(activity: IActivity) {
    this.activityId = activity.id;
  }
}
