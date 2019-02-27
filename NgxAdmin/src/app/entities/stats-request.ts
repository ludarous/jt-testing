export class StatsRequest {
  testId: number | string;
  eventId: number | string;
  dateFrom?: string;
  dateTo?: string;
  usersBirthdayFrom?: string;
  usersBirthdayTo?: string;
}
