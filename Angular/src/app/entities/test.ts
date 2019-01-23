import {ITestCategory} from './test-category';
import {ISport} from './sport';
import {Activity, IActivity, PersonalActivityStats} from './activity';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {ActivityResultUnits} from './enums/activity-result-units';
import {PersonalActivityCategoryResultsStats, PersonalCategoryStats} from './activity-category';

export interface ITest {
  id?: number;
  name?: string;
  description?: string;
  minAge?: number;
  maxAge?: number;

  activities: Array<IActivity>;
  categories?: Array<ITestCategory>;
  sports?: Array<ISport>;
}

export class Test implements ITest {
  id: number;
  name: string;
  description: string;
  minAge: number;
  maxAge: number;
  activities: Array<IActivity>;
  categories: Array<ITestCategory>;
  sports: Array<ISport>;


  static resolveResponse(response: HttpResponse<ITest>): ITest {
    const responseActivity = this.parseItemEnums(response.body);
    return responseActivity;
  }

  static parseItemEnums(test: any): ITest {
    if (test) {
     if (test.activities) {
       Activity.parseItemsEnums(test.activities);
     }
    }
    return test;
  }

  static parseItemsEnums(tests: Array<any>): Array<ITest> {
    if (tests) {
      for (const test of tests) {
        Test.parseItemEnums(test);
      }
    }
    return tests;
  }
}

export class PersonalTestStats {
  personalCategoryStats: PersonalCategoryStats;
  personalActivitiesStats: Array<PersonalActivityStats>;

  static resolveResponse(response: HttpResponse<PersonalTestStats>): PersonalTestStats {
    for (const activityStats of response.body.personalActivitiesStats) {
      activityStats.activity = Activity.parseItemEnums(activityStats.activity);
    }
    return response.body;
  }
}

