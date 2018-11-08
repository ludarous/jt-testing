export interface IActivityCategory {
  id?: number;
  name?: string;
  description?: string;
  key?: string;
}

export class ActivityCategory implements IActivityCategory {
  id: number;
  name: string;
  description: string;
  key: string;
}
