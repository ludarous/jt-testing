import {IWorkoutCategory} from './workout-category';
import {ISport} from './sport';
import {Activity, IActivity} from './activity';
import {HttpResponse} from '@angular/common/http';

export interface IWorkout {
  id?: number;
  name?: string;
  description?: string;
  minAge?: number;
  maxAge?: number;

  activities: Array<IActivity>;
  categories?: Array<IWorkoutCategory>;
  sports?: Array<ISport>;
}

export class Workout implements IWorkout {
  id: number;
  name: string;
  description: string;
  minAge: number;
  maxAge: number;
  activities: Array<IActivity>;
  categories: Array<IWorkoutCategory>;
  sports: Array<ISport>;


  static resolveResponse(response: HttpResponse<IWorkout>): IWorkout {
    const responseActivity = this.parseItemEnums(response.body);
    return responseActivity;
  }

  static parseItemEnums(test: any): IWorkout {
    if (test) {
     if (test.activities) {
       Activity.parseItemsEnums(test.activities);
     }
    }
    return test;
  }

  static parseItemsEnums(tests: Array<any>): Array<IWorkout> {
    if (tests) {
      for (const test of tests) {
        Workout.parseItemEnums(test);
      }
    }
    return tests;
  }
}

