import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {IActivity, PersonalActivityStats} from '../entities/activity';
import {ITest, PersonalTestStats} from '../entities/test';
import {Observable} from 'rxjs';
import {StatsRequest} from '../entities/stats-request';

@Injectable()
export class TestService extends CrudBaseService<ITest> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/jt-tests');
  }

  findMyStats(statsRequest: StatsRequest): Observable<HttpResponse<PersonalTestStats>> {
    return this.httpClient.post<PersonalTestStats>(`${this.resourceUrl}/my-stats`, statsRequest, { observe: 'response' });
  }
}
