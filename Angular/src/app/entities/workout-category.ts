export interface IWorkoutCategory {
  id?: number;
  name?: string;
  description?: string;
  key?: string;
}

export class WorkoutCategory implements IWorkoutCategory {
  id: number;
  name: string;
  description: string;
  key: string;
}
