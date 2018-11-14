import {Address, IAddress} from './address';
import {IPersonalData, PersonalData} from './personal-data';
import {IUser} from './user';

export interface IPersonFull {
  id?: any;
  email?: string;
  address?: IAddress;
  personalData?: IPersonalData;
  user?: IUser;
}

export class PersonFull implements IPersonFull {
  id: any;
  email: string;
  address: IAddress = new Address();
  personalData: IPersonalData = new PersonalData();
  user: IUser;
}
