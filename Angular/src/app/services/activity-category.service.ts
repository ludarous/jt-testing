import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {IActivityCategory, PersonalCategoryStats} from '../entities/activity-category';
import {PersonalActivityStats} from '../entities/activity';
import {Observable} from 'rxjs';
import {StatsRequest} from '../entities/stats-request';

@Injectable()
export class ActivityCategoryService extends CrudBaseService<IActivityCategory> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/activity-categories');
  }

  findMyStats(parentCategoryId: number, categoryStatsRequest: StatsRequest): Observable<HttpResponse<PersonalCategoryStats>> {
    return this.httpClient.post<PersonalCategoryStats>(`${this.resourceUrl}/my-stats`, categoryStatsRequest, { observe: 'response' });
  }
}
