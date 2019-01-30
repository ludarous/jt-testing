import {IActivityGroupCategory} from './activity-group-category';
import {ISport} from './sport';
import {Activity, IActivity} from './activity';
import {HttpResponse} from '@angular/common/http';

export interface IActivityGroup {
  id?: number;
  name?: string;
  description?: string;
  minAge?: number;
  maxAge?: number;

  activities: Array<IActivity>;
  categories?: Array<IActivityGroupCategory>;
  sports?: Array<ISport>;
}

export class ActivityGroup implements IActivityGroup {
  id: number;
  name: string;
  description: string;
  minAge: number;
  maxAge: number;
  activities: Array<IActivity>;
  categories: Array<IActivityGroupCategory>;
  sports: Array<ISport>;


  static resolveResponse(response: HttpResponse<IActivityGroup>): IActivityGroup {
    const responseActivity = this.parseItemEnums(response.body);
    return responseActivity;
  }

  static parseItemEnums(test: any): IActivityGroup {
    if (test) {
     if (test.activities) {
       Activity.parseItemsEnums(test.activities);
     }
    }
    return test;
  }

  static parseItemsEnums(tests: Array<any>): Array<IActivityGroup> {
    if (tests) {
      for (const test of tests) {
        ActivityGroup.parseItemEnums(test);
      }
    }
    return tests;
  }
}

