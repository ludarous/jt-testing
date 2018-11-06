export interface IActivityResult {
    id?: number;
    primaryResultValue?: number;
    secondaryResultValue?: number;
    note?: string;
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
        public testResultId?: number,
        public activityName?: string,
        public activityId?: number
    ) {}
}
