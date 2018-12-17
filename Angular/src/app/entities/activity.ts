import {ActivityResultUnits} from './enums/activity-result-units';
import {IActivityCategory} from './activity-category';
import {HttpResponse} from '@angular/common/http';
import {ITest} from './test';
import {IActivityResult} from './activity-result';

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

  static parseItemsEnums(activities: Array<any>): Array<IActivity> {
    if (activities) {
      for (const activity of activities) {
        Activity.parseItemEnums(activity);
      }
    }
    return activities;
  }
}

export class ActivityStats {
  activity: IActivity;
  activityResultsStats: ActivityResultStats;

  static resolveResponse(response: HttpResponse<ActivityStats>): ActivityStats {
    const activityStats = this.parseItemEnums(response.body);
    return activityStats;
  }

  static resolveArrayResponse(response: HttpResponse<Array<ActivityStats>>): Array<ActivityStats> {
    const activitiesStats = this.parseItemsEnums(response.body);
    return activitiesStats;
  }

  static parseItemEnums(activityStats: any): ActivityStats {
    if (activityStats && activityStats.activity) {
      if (activityStats.activity.primaryResultValueUnit != null) {
        activityStats.activity.primaryResultValueUnit = new ActivityResultUnits(<string>activityStats.activity.primaryResultValueUnit);
      }
      if (activityStats.activity.secondaryResultValueUnit != null) {
        activityStats.activity.secondaryResultValueUnit = new ActivityResultUnits(<string>activityStats.activity.secondaryResultValueUnit);
      }
    }
    return activityStats;
  }

  static parseItemsEnums(activitiesStats: Array<any>): Array<ActivityStats> {
    if (activitiesStats) {
      for (const activity of activitiesStats) {
        ActivityStats.parseItemEnums(activity);
      }
    }
    return activitiesStats;
  }

}

export class ActivityResultStats {
  primaryMin?: number;
  secondaryMin?: number;
  primaryAverage?: number;
  secondaryAverage?: number;
  primaryMedian?: number;
  secondaryMedian?: number;
  primaryMax?: number;
  secondaryMax?: number;
  primaryResultsCount?: number;
  secondaryResultsCount?: number;
}

export class PersonalActivityResultsStats {
  primaryPlacement: number;
  secondaryPlacement: number;

  totalPrimaryResults: number;
  totalSecondaryResults: number;
}

export class PersonalActivityStats extends ActivityStats {
  personalActivityResultsStats?: Array<PersonalActivityResultsStats>;
  personalActivityResults?: Array<IActivityResult>;
}
