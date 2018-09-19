export interface IPerson {
    id?: number;
    personalDataId?: number;
    addressId?: number;
}

export class Person implements IPerson {
    constructor(public id?: number, public personalDataId?: number, public addressId?: number) {}
}
