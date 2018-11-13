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
}
