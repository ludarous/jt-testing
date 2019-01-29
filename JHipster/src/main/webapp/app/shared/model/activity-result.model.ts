import { Moment } from 'moment';

export interface IActivityResult {
    id?: number;
    primaryResultValue?: number;
    secondaryResultValue?: number;
    note?: string;
    date?: Moment;
    official?: boolean;
    activityGroupResultId?: number;
    activityName?: string;
    activityId?: number;
    activityGroupName?: string;
    activityGroupId?: number;
    eventName?: string;
    eventId?: number;
    personEmail?: string;
    personId?: number;
}

export class ActivityResult implements IActivityResult {
    constructor(
        public id?: number,
        public primaryResultValue?: number,
        public secondaryResultValue?: number,
        public note?: string,
        public date?: Moment,
        public official?: boolean,
        public activityGroupResultId?: number,
        public activityName?: string,
        public activityId?: number,
        public activityGroupName?: string,
        public activityGroupId?: number,
        public eventName?: string,
        public eventId?: number,
        public personEmail?: string,
        public personId?: number
    ) {
        this.official = false;
    }
}
