import {IActivity} from './activity';
import {IWorkout} from './workout';
import {IEvent} from './event';

export interface IActivityResult {
  id?: number;
  primaryResultValue?: number;
  secondaryResultValue?: number;
  note?: string;

  date?: string;
  
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

  date: string;

  workoutResultId: number;

  activityId: number;
  activityName: number;

  workoutId: number;
  workoutName: string;

  eventId: number;
  eventName: string;

  personId: number;
  personName: string;

}
