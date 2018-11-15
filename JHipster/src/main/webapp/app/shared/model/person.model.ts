import { IEvent } from 'app/shared/model//event.model';

export interface IPerson {
    id?: number;
    email?: string;
    personalDataId?: number;
    addressId?: number;
    events?: IEvent[];
}

export class Person implements IPerson {
    constructor(
        public id?: number,
        public email?: string,
        public personalDataId?: number,
        public addressId?: number,
        public events?: IEvent[]
    ) {}
}
