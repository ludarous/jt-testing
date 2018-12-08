import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {ActivityStats, IActivity, PersonalActivityStats} from '../entities/activity';
import {Observable} from 'rxjs';
import {IEvent} from '../entities/event';
import {StatsRequest} from '../entities/stats-request';

@Injectable()
export class ActivityService extends CrudBaseService<IActivity> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/activities');
  }

  findStats(activityStatsRequest: StatsRequest): Observable<HttpResponse<ActivityStats>> {
    return this.httpClient.post<ActivityStats>(`${this.resourceUrl}/stats`, activityStatsRequest, { observe: 'response' });
  }

  findMyStats(activityId: number, statsRequest: StatsRequest): Observable<HttpResponse<PersonalActivityStats>> {
    return this.httpClient.post<PersonalActivityStats>(`${this.resourceUrl}/${activityId}/my-stats`, statsRequest, { observe: 'response' });
  }
}
