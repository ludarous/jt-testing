import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {IEvent} from '../entities/event';
import {Observable} from 'rxjs';
import {IEventResult} from '../entities/event-result';

@Injectable()
export class EventService extends CrudBaseService<IEvent> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/events');
  }

  queryEventResults(eventId: string | number): Observable<HttpResponse<Array<IEventResult>>> {
    return this.httpClient.get<Array<IEventResult>>(`${this.resourceUrl}/${eventId}/results`, { observe: 'response' });
  }

  queryMyEvents(): Observable<HttpResponse<Array<IEvent>>> {
    return this.httpClient.get<Array<IEvent>>(`${this.resourceUrl}/my`, { observe: 'response' });
  }
}
