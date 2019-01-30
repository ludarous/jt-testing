import { Moment } from 'moment';
import { IEventResult } from 'app/shared/model//event-result.model';
import { IActivityGroup } from 'app/shared/model//jt-test.model';
import { IPerson } from 'app/shared/model//person.model';

export interface IEvent {
    id?: number;
    name?: string;
    date?: Moment;
    minAge?: number;
    maxAge?: number;
    eventResults?: IEventResult[];
    addressStreet?: string;
    addressId?: number;
    tests?: IActivityGroup[];
    attachedPersons?: IPerson[];
}

export class Event implements IEvent {
    constructor(
        public id?: number,
        public name?: string,
        public date?: Moment,
        public minAge?: number,
        public maxAge?: number,
        public eventResults?: IEventResult[],
        public addressStreet?: string,
        public addressId?: number,
        public tests?: IActivityGroup[],
        public attachedPersons?: IPerson[]
    ) {}
}
