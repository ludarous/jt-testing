import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient} from '@angular/common/http';
import {IActivity} from '../entities/activity';
import {ITest} from '../entities/test';
import {IEventResult} from '../entities/event-result';

@Injectable()
export class EventResultService extends CrudBaseService<IEventResult> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/event-results');
  }
}
