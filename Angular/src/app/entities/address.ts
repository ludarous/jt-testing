export interface IAddress {
  id?: any;
  country?: string;
  city?: string;
  street?: string;
  zipCode?: string;
}

export class Address implements IAddress {
  id: any;
  country: string;
  city: string;
  street: string;
  zipCode: string;
}
