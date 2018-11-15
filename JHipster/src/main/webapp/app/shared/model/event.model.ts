import { Moment } from 'moment';
import { IEventResult } from 'app/shared/model//event-result.model';
import { IJTTest } from 'app/shared/model//jt-test.model';
import { IPerson } from 'app/shared/model//person.model';

export interface IEvent {
    id?: number;
    name?: string;
    date?: Moment;
    eventResults?: IEventResult[];
    addressStreet?: string;
    addressId?: number;
    tests?: IJTTest[];
    attachedPersons?: IPerson[];
}

export class Event implements IEvent {
    constructor(
        public id?: number,
        public name?: string,
        public date?: Moment,
        public eventResults?: IEventResult[],
        public addressStreet?: string,
        public addressId?: number,
        public tests?: IJTTest[],
        public attachedPersons?: IPerson[]
    ) {}
}
