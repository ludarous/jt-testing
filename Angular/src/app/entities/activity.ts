import {ActivityResultUnits} from './enums/activity-result-units';
import {IActivityCategory} from './activity-category';
import {HttpResponse} from '@angular/common/http';

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
  id: number;
  name: string;
  description: string;
  help: string;
  key: string;
  primaryResultValueUnit: ActivityResultUnits;
  secondaryResultValueUnit: ActivityResultUnits;
  minAge: number;
  maxAge: number;
  categories: Array<IActivityCategory>;

  static resolveResponse(response: HttpResponse<IActivity>): IActivity {
    const responseActivity = this.parseItemEnums(response.body);
    return responseActivity;
  }

  static parseItemEnums(activity: any): IActivity {
    if (activity) {
      if (activity.primaryResultValueUnit != null) {
        activity.primaryResultValueUnit = new ActivityResultUnits(<string>activity.primaryResultValueUnit);
      }
      if (activity.secondaryResultValueUnit != null) {
        activity.secondaryResultValueUnit = new ActivityResultUnits(<string>activity.secondaryResultValueUnit);
      }
    }
    return activity;
  }
}
