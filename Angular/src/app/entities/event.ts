import {ITest, Test} from './test';
import {IPerson} from './person';
import {IPersonFull} from './person-full';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {Activity} from './activity';
import {IEventResult} from './event-result';
import {forEach} from '@angular/router/src/utils/collection';

export interface IEvent {
  id?: number;
  name?: string;
  date?: string;
  minAge?: number;
  maxAge?: number;

  addressId?: number;
  addressStreet?: string;
  
  tests?: Array<ITest>;
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

  tests: Array<ITest>;
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
      if (event.tests) {
        Test.parseItemsEnums(event.tests);
      }
    }
    return event;
  }

  static parseItemsEnums(events: Array<any>): Array<IEvent> {
    if (events) {
      for (const event of events) {
        Test.parseItemEnums(event);
      }
    }
    return events;
  }
}
