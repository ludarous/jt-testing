import {ITest} from './test';

export interface IEvent {
  id?: number;
  name?: string;
  date?: string;
  
  addressId?: number;
  addressStreet?: string;
  
  tests?: Array<ITest>;
  
}

export class Event implements IEvent {
  id: number;
  name: string;
  date: string;

  addressId: number;
  addressStreet: string;

  tests: Array<ITest>;
}
