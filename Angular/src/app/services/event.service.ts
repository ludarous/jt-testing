import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IEvent} from '../entities/event';

@Injectable()
export class EventService extends CrudBaseService<IEvent> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/events');
  }
}
