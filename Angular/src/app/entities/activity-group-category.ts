export interface IActivityGroupCategory {
  id?: number;
  name?: string;
  description?: string;
  key?: string;
}

export class ActivityGroupCategory implements IActivityGroupCategory {
  id: number;
  name: string;
  description: string;
  key: string;
}
