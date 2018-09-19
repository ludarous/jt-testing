import { Moment } from 'moment';

export interface IPersonalData {
    id?: number;
    firstName?: string;
    lastName?: string;
    birthDate?: Moment;
    nationality?: string;
}

export class PersonalData implements IPersonalData {
    constructor(
        public id?: number,
        public firstName?: string,
        public lastName?: string,
        public birthDate?: Moment,
        public nationality?: string
    ) {}
}
