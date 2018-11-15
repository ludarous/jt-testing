export interface IPerson {
    id?: number;
    email?: string;
    personalDataId?: number;
    addressId?: number;
}

export class Person implements IPerson {
    constructor(public id?: number, public email?: string, public personalDataId?: number, public addressId?: number) {}
}
