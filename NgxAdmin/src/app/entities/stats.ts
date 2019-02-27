import {ActivityResult, IActivityResult} from './activity-result';
import {Activity, IActivity} from './activity';
import {HttpResponse} from '@angular/common/http';
import {ActivityResultUnits} from './enums/activity-result-units';
import {IActivityCategory} from './activity-category';

export class Stats {

  static resolveResponse(response: HttpResponse<PersonalStats>): PersonalStats {
    const activityStats = this.parseItemEnums(response.body);
    return activityStats;
  }

  static resolveArrayResponse(response: HttpResponse<Array<PersonalStats>>): Array<PersonalStats> {
    const activitiesStats = this.parseItemsEnums(response.body);
    return activitiesStats;
  }

  static parseItemEnums(stats: PersonalStats): PersonalStats {

    if (stats && stats.activitiesStats) {
      stats.activitiesStats = Stats.parsePersonalActivitiesStats(stats.activitiesStats);
    }

    return stats;
  }

  static parseItemsEnums(stats: Array<any>): Array<PersonalStats> {
    if (stats) {
      for (const stat of stats) {
        Stats.parseItemEnums(stat);
      }
    }
    return stats;
  }

  static parsePersonalActivityStats(personalActivityStats: any): PersonalActivityStats {

    if (personalActivityStats.activity.primaryResultValueUnit != null) {
      personalActivityStats.activity.primaryResultValueUnit =
        new ActivityResultUnits(<string>personalActivityStats.activity.primaryResultValueUnit);
    }

    if (personalActivityStats.activity.secondaryResultValueUnit != null) {
      personalActivityStats.activity.secondaryResultValueUnit =
        new ActivityResultUnits(<string>personalActivityStats.activity.secondaryResultValueUnit);
    }
    return personalActivityStats;
  }

  static parsePersonalActivitiesStats(personalActivitiesStats: Array<any>): Array<PersonalActivityStats> {
    if (personalActivitiesStats) {
      for (const personalActivityStats of personalActivitiesStats) {
        Stats.parsePersonalActivityStats(personalActivityStats);
      }
    }
    return personalActivitiesStats;
  }
}

export class PersonalStats {
  activitiesStats?: Array<PersonalActivityStats>;
  categoriesStats?: Array<PersonalCategoryStats>;
}

export class ActivityResultStats {
  resultsMinValue?: number;
  resultsAverageValue?: number;
  resultsMedianValue?: number;
  resultsMaxValue?: number;
  resultsCount?: number;
}

export class PersonalActivityResultsStats {
  bestValue?: number;
  averageValue?: number;
  worstValue?: number;

  bestPlacement?: number;
  averagePlacement?: number;
  worstPlacement?: number;

  bestPlacementInPercents?: number;
  averagePlacementInPercents?: number;
  worstPlacementInPercents?: number;
}

export class PersonalActivityStats {
  activity: IActivity;
  primaryResultsStats: ActivityResultStats;
  secondaryResultsStats: ActivityResultStats;

  primaryPersonalActivityStats: PersonalActivityResultsStats;
  secondaryPersonalActivityStats: PersonalActivityResultsStats;

  personalActivityResults: Array<ActivityResult>;
}

export class PersonalCategoryResultsStats {
  avaregePlacement: number;
  averagePlacementInPercents: number;
}

export class PersonalCategoryStats {

  category: IActivityCategory;
  primaryCategoryResultsStats: PersonalCategoryResultsStats;
  secondaryCategoryResultsStats: PersonalCategoryResultsStats;
  childCategoryPersonalStats: Array<PersonalCategoryStats>;

}
