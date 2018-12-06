import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {ActivityStats, ActivityStatsRequest, IActivity, PersonalActivityStats} from '../entities/activity';
import {Observable} from 'rxjs';
import {IEvent} from '../entities/event';

@Injectable()
export class ActivityService extends CrudBaseService<IActivity> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/activities');
  }

  findStats(activityStatsRequest: ActivityStatsRequest): Observable<HttpResponse<ActivityStats>> {
    return this.httpClient.post<ActivityStats>(`${this.resourceUrl}/stats`, activityStatsRequest, { observe: 'response' });
  }

  findMyStats(activityStatsRequest: ActivityStatsRequest): Observable<HttpResponse<PersonalActivityStats>> {
    return this.httpClient.post<PersonalActivityStats>(`${this.resourceUrl}/my-stats`, activityStatsRequest, { observe: 'response' });
  }
}
