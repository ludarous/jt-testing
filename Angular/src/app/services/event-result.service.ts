import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {IActivity} from '../entities/activity';
import {ITest} from '../entities/test';
import {IEventResult} from '../entities/event-result';
import {Observable} from 'rxjs';

@Injectable()
export class EventResultService extends CrudBaseService<IEventResult> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/event-results');
  }

  queryMyEventResults(): Observable<HttpResponse<Array<IEventResult>>> {
    return this.httpClient.get<Array<IEventResult>>(`${this.resourceUrl}/my`, { observe: 'response' });
  }
}
