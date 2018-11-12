import {ITestCategory} from './test-category';
import {ISport} from './sport';
import {IActivity} from './activity';

export interface ITest {
  id?: number;
  name?: string;
  description?: string;
  activities: Array<IActivity>;
  categories?: Array<ITestCategory>;
  sports?: Array<ISport>;
}

export class Test implements ITest {
  id: number;
  name: string;
  description: string;
  activities: Array<IActivity>;
  categories: Array<ITestCategory>;
  sports: Array<ISport>;
}
