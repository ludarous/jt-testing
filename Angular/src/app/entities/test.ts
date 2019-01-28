import {ITestCategory} from './test-category';
import {ISport} from './sport';
import {Activity, IActivity} from './activity';
import {HttpResponse} from '@angular/common/http';

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

