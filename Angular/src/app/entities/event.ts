import {ITest, Test} from './test';
import {IPerson} from './person';
import {IPersonFull} from './person-full';
import {HttpResponse} from '@angular/common/http';
import {Activity} from './activity';
import {IEventResult} from './event-result';

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
