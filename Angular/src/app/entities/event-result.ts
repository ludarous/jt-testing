import {ITestResult, TestResult} from './test-result';
import {IEvent} from './event';
import {IPersonFull} from './person-full';

export interface IEventResult {
  id?: number;
  note?: string;

  actualHeightInCm?: number;
  actualWeightInKg?: number;

  eventId?: number;
  personId?: number;

  testResults?: Array<ITestResult>;
}

export class EventResult implements IEventResult {
  id: number;
  note: string;

  actualHeightInCm: number;
  actualWeightInKg: number;

  eventId: number;
  personId: number;

  testResults: Array<ITestResult> = new Array<ITestResult>();

  constructor(event: IEvent, person: IPersonFull) {
    this.eventId = event.id;
    this.personId = person.id;

    for (const test of event.tests) {
      this.testResults.push(new TestResult(test));
    }
  }
}
