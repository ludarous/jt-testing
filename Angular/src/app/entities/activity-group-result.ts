import {ActivityResult, IActivityResult} from './activity-result';
import {IActivityGroup} from './activity-group';

export interface IActivityGroupResult {
  id?: number;
  note?: string;

  eventResultId?: number;
  
  activityGroupId?: number;
  activityGroupName?: string;

  activitiesResults?: Array<IActivityResult>;
}

export class ActivityGroupResult implements IActivityGroupResult {
  id: number;
  note: string;

  eventResultId: number;

  activityGroupId: number;
  activityGroupName: string;

  activitiesResults: Array<IActivityResult> = new Array<IActivityResult>();

  constructor(activityGroup: IActivityGroup) {
    this.activityGroupId = activityGroup.id;
    for (const activity of activityGroup.activities) {
      this.activitiesResults.push(new ActivityResult(activity));
    }
  }
}
