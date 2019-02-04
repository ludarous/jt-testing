import { Moment } from 'moment';
import { IEventResult } from 'app/shared/model//event-result.model';
import { IWorkout } from 'app/shared/model//activity-group.model';
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
    workouts?: IWorkout[];
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
        public workouts?: IWorkout[],
        public attachedPersons?: IPerson[]
    ) {}
}
