import {ActivityResult, IActivityResult} from './activity-result';
import {IWorkout} from './workout';
import {IEvent} from './event';

export interface IWorkoutResult {
  id?: number;
  note?: string;

  eventResultId?: number;
  
  workoutId?: number;
  workoutName?: string;

  activitiesResults?: Array<IActivityResult>;
}

export class WorkoutResult implements IWorkoutResult {
  id: number;
  note: string;

  eventResultId: number;

  workoutId: number;
  workoutName: string;

  activitiesResults: Array<IActivityResult> = new Array<IActivityResult>();

  constructor(workout: IWorkout, event: IEvent) {
    this.workoutId = workout.id;
    for (const activity of workout.activities) {
      this.activitiesResults.push(new ActivityResult(activity, workout, event));
    }
  }
}
