import {IPersonFull} from './person-full';

export interface IPerson {
  id?: any;
  addressId?: number;
  personalDataId?: number;
  userId?: number;
}

export class Person implements IPerson {
  id: any;
  addressId: number;
  personalDataId: number;
  userId: number;

  static createPerson(personFull: IPersonFull): IPerson {
    const person = new Person();
    person.id = personFull.id;
    if (personFull.address) person.addressId = personFull.address.id;
    if (personFull.personalData) person.personalDataId = personFull.personalData.id;
    if (personFull.user) person.userId = personFull.user.id;
    return person;
  }
}
