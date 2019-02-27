import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {IActivity} from '../entities/activity';
import {Observable} from 'rxjs';
import {StatsRequest} from '../entities/stats-request';
import {PersonalStats} from '../entities/stats';

@Injectable()
export class StatsService extends CrudBaseService<IActivity> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/stats');
  }

  findMyStats(activityStatsRequest: StatsRequest): Observable<HttpResponse<PersonalStats>> {
    return this.httpClient.post<PersonalStats>(`${this.resourceUrl}/my-stats`, activityStatsRequest, { observe: 'response' });
  }

}
