import {IWorkoutResult, WorkoutResult} from './workout-result';
import {IEvent} from './event';
import {IPersonFull} from './person-full';

export interface IEventResult {
  id?: number;
  note?: string;

  actualHeightInCm?: number;
  actualWeightInKg?: number;

  eventId?: number;
  personId?: number;

  workoutResults?: Array<IWorkoutResult>;
}

export class EventResult implements IEventResult {
  id: number;
  note: string;

  actualHeightInCm: number;
  actualWeightInKg: number;

  eventId: number;
  personId: number;

  workoutResults: Array<IWorkoutResult> = new Array<IWorkoutResult>();

  constructor(event: IEvent, person: IPersonFull) {
    this.eventId = event.id;
    this.personId = person.id;

    for (const test of event.workouts) {
      this.workoutResults.push(new WorkoutResult(test));
    }
  }
}
