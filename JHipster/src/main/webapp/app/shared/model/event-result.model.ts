import { IWorkoutResult } from 'app/shared/model//workout-result.model';

export interface IEventResult {
    id?: number;
    note?: string;
    actualHeightInCm?: number;
    actualWeightInKg?: number;
    eventId?: number;
    workoutResults?: IWorkoutResult[];
    personId?: number;
}

export class EventResult implements IEventResult {
    constructor(
        public id?: number,
        public note?: string,
        public actualHeightInCm?: number,
        public actualWeightInKg?: number,
        public eventId?: number,
        public workoutResults?: IWorkoutResult[],
        public personId?: number
    ) {}
}
