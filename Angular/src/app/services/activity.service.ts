import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient} from '@angular/common/http';
import {IActivity} from '../entities/activity';

@Injectable()
export class ActivityService extends CrudBaseService<IActivity> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/activities');
  }
}
