export interface ITestResult {
  id?: number;
  note?: string;

  eventResultId?: number;
  
  testId?: number;
  testName?: string;
}

export class TestResult implements ITestResult {
  id: number;
  note: string;

  eventResultId: number;

  testId: number;
  testName: string;
}
