import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IActivity} from '../entities/activity';

@Injectable()
export class ActivityService extends CrudBaseService<IActivity> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/activities');
  }

}
