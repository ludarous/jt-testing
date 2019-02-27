export interface IActivityCategory {
  id?: number;
  name?: string;
  description?: string;
  key?: string;
  parentId?: number;

  parent?: ActivityCategory;
  children?: Array<ActivityCategory>;
}

export class ActivityCategory implements IActivityCategory {
  id: number;
  name: string;
  description: string;
  key: string;
  parentId?: number;


  parent: ActivityCategory;
  children: Array<ActivityCategory>;
}
