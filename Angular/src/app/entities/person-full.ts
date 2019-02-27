import {Address, IAddress} from './address';
import {IPersonalData, PersonalData} from './personal-data';
import {IUser} from './user';
import {StringUtils} from '../../../../NgxAdmin/src/app/@core/utils/string-utils';
import {HttpResponse} from '@angular/common/http';
import {Workout} from './workout';
import {IEvent} from './event';
import {IPerson} from './person';

export interface IPersonFull {
  id?: any;
  email?: string;
  virtual?: boolean;
  address?: IAddress;
  personalData?: IPersonalData;
  user?: IUser;
}

export class PersonFull implements IPersonFull {
  id: any;
  email: string;
  virtual: boolean;
  address: IAddress = new Address();
  personalData: IPersonalData = new PersonalData();
  user: IUser;

  static sortByName(input: Array<IPersonFull>, order = 1) {
    if (input) {
      const comparer = function (o1: IPersonFull, o2: IPersonFull) {
        if (o1.personalData && o2.personalData) {
          return StringUtils.sortBy2Strings(
            o1.personalData.firstName,
            o1.personalData.lastName,
            o2.personalData.firstName,
            o2.personalData.lastName,
            order);

        } else {
          return 0;
        }
      };
      return input.sort(comparer);
    }
    return input;
  }

  static resolveResponse(response: HttpResponse<IPersonFull>): IPersonFull {
    const responsePerson = this.parseItemEnums(response.body);
    return responsePerson;
  }

  static resolveArrayResponse(response: HttpResponse<Array<IPersonFull>>): Array<IPersonFull> {
    const persons = response.body;
    for (const person of persons) {
      PersonFull.parseItemEnums(person);
    }
    return persons;
  }

  static parseItemEnums(person: any): IPersonFull {
    if (person) {
      if (person.personalData) {
        PersonalData.parseItemEnums(person.personalData);
      }
    }
    return person;
  }

  static parseItemsEnums(persons: Array<any>): Array<IPersonFull> {
    if (persons) {
      for (const person of persons) {
        PersonFull.parseItemEnums(person);
      }
    }
    return persons;
  }
}
