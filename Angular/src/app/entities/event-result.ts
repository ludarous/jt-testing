export interface IEventResult {
  id?: number;
  note?: string;

  actualHeightInCm?: number;
  actualWeightInKg?: number;

  eventId?: number;
  personId?: number;
}

export class EventResult implements IEventResult {
  id: number;
  note: string;

  actualHeightInCm: number;
  actualWeightInKg: number;

  eventId: number;
  personId: number;
}
