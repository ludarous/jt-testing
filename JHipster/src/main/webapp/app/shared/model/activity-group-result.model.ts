import { IActivityResult } from 'app/shared/model//activity-result.model';

export interface IWorkoutResult {
    id?: number;
    note?: string;
    eventResultId?: number;
    activitiesResults?: IActivityResult[];
    workoutName?: string;
    workoutId?: number;
}

export class WorkoutResult implements IWorkoutResult {
    constructor(
        public id?: number,
        public note?: string,
        public eventResultId?: number,
        public activitiesResults?: IActivityResult[],
        public workoutName?: string,
        public workoutId?: number
    ) {}
}
