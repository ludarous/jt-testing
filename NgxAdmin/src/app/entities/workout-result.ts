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

}
