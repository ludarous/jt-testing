import {IActivity} from './activity';

export interface IActivityCategory {
  id?: number;
  name?: string;
  description?: string;
  key?: string;
  parentId?: number;

  parent?: ActivityCategory;
  chidlren?: Array<ActivityCategory>;
}

export class ActivityCategory implements IActivityCategory {
  id: number;
  name: string;
  description: string;
  key: string;
  parentId?: number;


  parent: ActivityCategory;
  chidlren: Array<ActivityCategory>;
}

export class PersonalActivityCategoryResultsStats {
  category: ActivityCategory;
  primaryPlacement: number;
  secondaryPlacement: number;
}

export class PersonalCategoryStats {
  parentCategory: ActivityCategory;
  personalCategoriesResultsStats?: Array<PersonalActivityCategoryResultsStats>;
}
