import {IActivityGroupResult, ActivityGroupResult} from './activity-group-result';
import {IEvent} from './event';
import {IPersonFull} from './person-full';

export interface IEventResult {
  id?: number;
  note?: string;

  actualHeightInCm?: number;
  actualWeightInKg?: number;

  eventId?: number;
  personId?: number;

  activityGroupResults?: Array<IActivityGroupResult>;
}

export class EventResult implements IEventResult {
  id: number;
  note: string;

  actualHeightInCm: number;
  actualWeightInKg: number;

  eventId: number;
  personId: number;

  activityGroupResults: Array<IActivityGroupResult> = new Array<IActivityGroupResult>();

  constructor(event: IEvent, person: IPersonFull) {
    this.eventId = event.id;
    this.personId = person.id;

    for (const test of event.activityGroups) {
      this.activityGroupResults.push(new ActivityGroupResult(test));
    }
  }
}
