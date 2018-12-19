import { Moment } from 'moment';

export interface IActivityResult {
    id?: number;
    primaryResultValue?: number;
    secondaryResultValue?: number;
    note?: string;
    eventDate?: Moment;
    personBirthDate?: Moment;
    testResultId?: number;
    activityName?: string;
    activityId?: number;
    testName?: string;
    testId?: number;
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
        public eventDate?: Moment,
        public personBirthDate?: Moment,
        public testResultId?: number,
        public activityName?: string,
        public activityId?: number,
        public testName?: string,
        public testId?: number,
        public eventName?: string,
        public eventId?: number,
        public personEmail?: string,
        public personId?: number
    ) {}
}
