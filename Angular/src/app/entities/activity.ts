import {ActivityResultUnits} from './enums/activity-result-units';
import {IActivityCategory} from './activity-category';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {IWorkout} from './workout';
import {IActivityResult} from './activity-result';
import {ResultType} from './enums/result-type';

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
  primaryResultType?: ResultType;
  secondaryResultType?: ResultType;
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
  primaryResultType: ResultType;
  secondaryResultType: ResultType;
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
      if (activity.primaryResultType != null) {
        activity.primaryResultType = new ResultType(<string>activity.primaryResultType);
      }
      if (activity.secondaryResultType != null) {
        activity.secondaryResultType = new ResultType(<string>activity.secondaryResultType);
      }
    }
    return activity;
  }

  static parseItemsEnums(activities: Array<any>): Array<IActivity> {
    if (activities) {
      for (const activity of activities) {
        Activity.parseItemEnums(activity);
      }
    }
    return activities;
  }
}
