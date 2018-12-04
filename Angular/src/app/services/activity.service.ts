import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {ActivityStats, IActivity} from '../entities/activity';
import {Observable} from 'rxjs';
import {IEvent} from '../entities/event';

@Injectable()
export class ActivityService extends CrudBaseService<IActivity> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/activities');
  }

  findStats(id: string | number): Observable<HttpResponse<ActivityStats>> {
    return this.httpClient.get<ActivityStats>(`${this.resourceUrl}/${id}/stats`, { observe: 'response' });
  }
}
