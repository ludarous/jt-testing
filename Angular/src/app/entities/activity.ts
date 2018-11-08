import {ActivityResultUnits} from './enums/activity-result-units';
import {IActivityCategory} from './activity-category';

export interface IActivity {
  id?: number;
  name?: string;
  description?: string;
  help?: string;
  key?: string;
  primaryResultValueUnit?: ActivityResultUnits;
  secondaryResultValueUnit?: ActivityResultUnits;
  minAge?: number;
  maxAge?: number;
  categories?: Array<IActivityCategory>;
}

export class Activity implements IActivity {
  constructor(
    public id: number,
    public  name: string,
    public description: string,
    public help: string,
    public key: string,
    public primaryResultValueUnit: ActivityResultUnits,
    public secondaryResultValueUnit: ActivityResultUnits,
    public minAge: number,
    public maxAge: number,
    public categories: Array<IActivityCategory>,
  ) {
    this.id = id ? id : null;
    this.name = name ? name : null;
    this.description = description ? description : null;
    this.help = help ? help : null;
    this.key = key ? key : null;
    this.primaryResultValueUnit = primaryResultValueUnit ? primaryResultValueUnit : null;
    this.secondaryResultValueUnit = secondaryResultValueUnit ? secondaryResultValueUnit : null;
    this.minAge = minAge ? minAge : null;
    this.maxAge = maxAge ? maxAge : null;
    this.categories = categories ? categories : null;
  }
}
