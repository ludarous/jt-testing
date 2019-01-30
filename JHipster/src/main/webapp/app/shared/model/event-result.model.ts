import { IActivityGroupResult } from 'app/shared/model//activity-group-result.model';

export interface IEventResult {
    id?: number;
    note?: string;
    actualHeightInCm?: number;
    actualWeightInKg?: number;
    eventId?: number;
    activityGroupResults?: IActivityGroupResult[];
    personId?: number;
}

export class EventResult implements IEventResult {
    constructor(
        public id?: number,
        public note?: string,
        public actualHeightInCm?: number,
        public actualWeightInKg?: number,
        public eventId?: number,
        public activityGroupResults?: IActivityGroupResult[],
        public personId?: number
    ) {}
}
