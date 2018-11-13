import {IAddress} from './address';
import {IPersonalData} from './personal-data';
import {IUser} from './user';

export interface IPersonFull {
  id?: any;
  address?: IAddress;
  personalData?: IPersonalData;
  user?: IUser;
}

export class PersonFull implements IPersonFull {
  id: any;
  address: IAddress;
  personalData: IPersonalData;
  user: IUser;
}
