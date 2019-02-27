import {IActivity} from './activity';
import {IWorkout} from './workout';
import {IEvent} from './event';

export interface IActivityResult {
  id?: number;
  primaryResultValue?: number;
  secondaryResultValue?: number;
  note?: string;
  
  workoutResultId?: number;
  activityId?: number;
  activityName?: number;

  workoutId?: number;
  workoutName?: string;

  eventId?: number;
  eventName?: string;

  personId?: number;
  personName?: string;

}

export class ActivityResult implements IActivityResult {
  id: number;
  primaryResultValue: number;
  secondaryResultValue: number;
  note: string;

  workoutResultId: number;

  activityId: number;
  activityName: number;

  workoutId: number;
  workoutName: string;

  eventId: number;
  eventName: string;

  personId: number;
  personName: string;

  constructor(activity: IActivity, workout: IWorkout, event: IEvent) {
    this.activityId = activity.id;
    this.workoutId = workout.id;
    this.eventId = event.id;
  }
}
