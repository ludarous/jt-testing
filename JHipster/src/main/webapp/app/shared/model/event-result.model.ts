import { ITestResult } from 'app/shared/model//test-result.model';

export interface IEventResult {
    id?: number;
    note?: string;
    actualHeightInCm?: number;
    actualWeightInKg?: number;
    eventId?: number;
    testResults?: ITestResult[];
    personId?: number;
}

export class EventResult implements IEventResult {
    constructor(
        public id?: number,
        public note?: string,
        public actualHeightInCm?: number,
        public actualWeightInKg?: number,
        public eventId?: number,
        public testResults?: ITestResult[],
        public personId?: number
    ) {}
}
