import {ITest} from './test';
import {IPerson} from './person';

export interface IEvent {
  id?: number;
  name?: string;
  date?: string;
  
  addressId?: number;
  addressStreet?: string;
  
  tests?: Array<ITest>;
  attachedPersons?: Array<IPerson>;
  
}

export class Event implements IEvent {
  id: number;
  name: string;
  date: string;

  addressId: number;
  addressStreet: string;

  tests: Array<ITest>;
  attachedPersons: Array<IPerson>;
}
