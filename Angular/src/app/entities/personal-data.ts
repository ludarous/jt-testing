export interface IPersonalData {
  id?: any;
  firstName?: string;
  lastName?: string;
  birthDate?: string;
  nationality?: string;
}

export class PersonalData implements IPersonalData {
  id: any;
  firstName: string;
  lastName: string;
  birthDate: string;
  nationality: string;
}
