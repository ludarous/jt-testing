import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient} from '@angular/common/http';
import {IActivity} from '../entities/activity';
import {ITest} from '../entities/test';

@Injectable()
export class TestService extends CrudBaseService<ITest> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/jt-tests');
  }
}
