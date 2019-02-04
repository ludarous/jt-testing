import { Moment } from 'moment';

export interface IActivityResult {
    id?: number;
    primaryResultValue?: number;
    secondaryResultValue?: number;
    note?: string;
    date?: Moment;
    official?: boolean;
    workoutResultId?: number;
    activityName?: string;
    activityId?: number;
    workoutName?: string;
    workoutId?: number;
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
        public workoutResultId?: number,
        public activityName?: string,
        public activityId?: number,
        public workoutName?: string,
        public workoutId?: number,
        public eventName?: string,
        public eventId?: number,
        public personEmail?: string,
        public personId?: number
    ) {
        this.official = false;
    }
}
