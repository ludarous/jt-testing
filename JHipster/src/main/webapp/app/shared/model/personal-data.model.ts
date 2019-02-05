import { Moment } from 'moment';

export const enum Sex {
    MALE = 'MALE',
    FEMALE = 'FEMALE',
    OTHER = 'OTHER'
}

export interface IPersonalData {
    id?: number;
    firstName?: string;
    lastName?: string;
    birthDate?: Moment;
    nationality?: string;
    sex?: Sex;
}

export class PersonalData implements IPersonalData {
    constructor(
        public id?: number,
        public firstName?: string,
        public lastName?: string,
        public birthDate?: Moment,
        public nationality?: string,
        public sex?: Sex
    ) {}
}
