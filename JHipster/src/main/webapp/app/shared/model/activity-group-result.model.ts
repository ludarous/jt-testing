import { IActivityResult } from 'app/shared/model//activity-result.model';

export interface IActivityGroupResult {
    id?: number;
    note?: string;
    eventResultId?: number;
    activitiesResults?: IActivityResult[];
    activityGroupName?: string;
    activityGroupId?: number;
}

export class ActivityGroupResult implements IActivityGroupResult {
    constructor(
        public id?: number,
        public note?: string,
        public eventResultId?: number,
        public activitiesResults?: IActivityResult[],
        public activityGroupName?: string,
        public activityGroupId?: number
    ) {}
}
