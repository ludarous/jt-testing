import {ActivityResult, IActivityResult} from './activity-result';
import {IActivityGroup} from './activity-group';

export interface IActivityGroupResult {
  id?: number;
  note?: string;

  eventResultId?: number;
  
  testId?: number;
  testName?: string;

  activitiesResults?: Array<IActivityResult>;
}

export class ActivityGroupResult implements IActivityGroupResult {
  id: number;
  note: string;

  eventResultId: number;

  testId: number;
  testName: string;

  activitiesResults: Array<IActivityResult> = new Array<IActivityResult>();

  constructor(test: IActivityGroup) {
    this.testId = test.id;
    for (const activity of test.activities) {
      this.activitiesResults.push(new ActivityResult(activity));
    }
  }
}
