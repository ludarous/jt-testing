import { Moment } from 'moment';

export interface IActivityResult {
    id?: number;
    primaryResultValue?: number;
    secondaryResultValue?: number;
    note?: string;
    eventDate?: Moment;
    testResultId?: number;
    activityName?: string;
    activityId?: number;
}

export class ActivityResult implements IActivityResult {
    constructor(
        public id?: number,
        public primaryResultValue?: number,
        public secondaryResultValue?: number,
        public note?: string,
        public eventDate?: Moment,
        public testResultId?: number,
        public activityName?: string,
        public activityId?: number
    ) {}
}
