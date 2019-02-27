import { IActivity } from 'app/shared/model//activity.model';
import { IWorkoutCategory } from 'app/shared/model//workout-category.model';

export interface IWorkout {
    id?: number;
    name?: string;
    description?: string;
    minAge?: number;
    maxAge?: number;
    activities?: IActivity[];
    workoutCategories?: IWorkoutCategory[];
}

export class Workout implements IWorkout {
    constructor(
        public id?: number,
        public name?: string,
        public description?: string,
        public minAge?: number,
        public maxAge?: number,
        public activities?: IActivity[],
        public workoutCategories?: IWorkoutCategory[]
    ) {}
}
