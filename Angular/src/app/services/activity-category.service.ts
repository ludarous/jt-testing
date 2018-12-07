import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {ActivityCategoryStatsRequest, IActivityCategory, PersonalCategoryStats} from '../entities/activity-category';
import {ActivityStatsRequest, PersonalActivityStats} from '../entities/activity';
import {Observable} from 'rxjs';

@Injectable()
export class ActivityCategoryService extends CrudBaseService<IActivityCategory> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/activity-categories');
  }

  findMyStats(categoryStatsRequest: ActivityCategoryStatsRequest): Observable<HttpResponse<PersonalCategoryStats>> {
    return this.httpClient.post<PersonalCategoryStats>(`${this.resourceUrl}/my-stats`, categoryStatsRequest, { observe: 'response' });
  }
}
