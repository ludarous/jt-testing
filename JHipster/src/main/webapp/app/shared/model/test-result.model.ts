import { IActivityResult } from 'app/shared/model//activity-result.model';

export interface ITestResult {
    id?: number;
    note?: string;
    eventResultId?: number;
    activitiesResults?: IActivityResult[];
    testName?: string;
    testId?: number;
}

export class TestResult implements ITestResult {
    constructor(
        public id?: number,
        public note?: string,
        public eventResultId?: number,
        public activitiesResults?: IActivityResult[],
        public testName?: string,
        public testId?: number
    ) {}
}
