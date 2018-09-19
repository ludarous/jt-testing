import { Moment } from 'moment';
import { IEventResult } from 'app/shared/model//event-result.model';
import { IJTTest } from 'app/shared/model//jt-test.model';

export interface IEvent {
    id?: number;
    name?: string;
    date?: Moment;
    eventResults?: IEventResult[];
    addressId?: number;
    tests?: IJTTest[];
}

export class Event implements IEvent {
    constructor(
        public id?: number,
        public name?: string,
        public date?: Moment,
        public eventResults?: IEventResult[],
        public addressId?: number,
        public tests?: IJTTest[]
    ) {}
}
