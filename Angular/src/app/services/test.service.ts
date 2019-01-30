import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IActivityGroup} from '../entities/activity-group';

@Injectable()
export class TestService extends CrudBaseService<IActivityGroup> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/jt-tests');
  }
}
