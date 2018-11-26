import {ActivityResult, IActivityResult} from './activity-result';
import {ITest} from './test';

export interface ITestResult {
  id?: number;
  note?: string;

  eventResultId?: number;
  
  testId?: number;
  testName?: string;

  activitiesResults?: Array<IActivityResult>;
}

export class TestResult implements ITestResult {
  id: number;
  note: string;

  eventResultId: number;

  testId: number;
  testName: string;

  activitiesResults: Array<IActivityResult> = new Array<IActivityResult>();

  constructor(test: ITest) {
    this.testId = test.id;
    for (const activity of test.activities) {
      this.activitiesResults.push(new ActivityResult(activity));
    }
  }
}
