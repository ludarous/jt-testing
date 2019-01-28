import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {ITest} from '../entities/test';

@Injectable()
export class TestService extends CrudBaseService<ITest> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/jt-tests');
  }
}
