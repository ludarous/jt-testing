import {Workout, IWorkout} from './workout';
import {IPersonFull} from './person-full';
import {HttpResponse} from '@angular/common/http';
import {IEventResult} from './event-result';

export interface IEvent {
  id?: number;
  name?: string;
  date?: string;
  minAge?: number;
  maxAge?: number;

  addressId?: number;
  addressStreet?: string;

  workouts?: Array<IWorkout>;
  attachedPersons?: Array<IPersonFull>;
  eventResults?: Array<IEventResult>;
  
}

export class Event implements IEvent {
  id: number;
  name: string;
  date: string;
  minAge: number;
  maxAge: number;

  addressId: number;
  addressStreet: string;

  workouts: Array<IWorkout>;
  attachedPersons: Array<IPersonFull>;
  eventResults: Array<IEventResult>;

  static resolveResponse(response: HttpResponse<IEvent>): IEvent {
    const responseActivity = this.parseItemEnums(response.body);
    return responseActivity;
  }

  static resolveArrayResponse(response: HttpResponse<Array<IEvent>>): Array<IEvent> {
    const events = response.body;
    for (const event of events) {
      Event.parseItemEnums(event);
    }
    return events;
  }

  static parseItemEnums(event: any): IEvent {
    if (event) {
      if (event.workouts) {
        Workout.parseItemsEnums(event.workouts);
      }
    }
    return event;
  }

  static parseItemsEnums(events: Array<any>): Array<IEvent> {
    if (events) {
      for (const event of events) {
        Workout.parseItemEnums(event);
      }
    }
    return events;
  }
}
