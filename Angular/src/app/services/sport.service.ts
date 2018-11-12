import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IActivityCategory} from '../entities/activity-category';
import {ISport} from '../entities/sport';

@Injectable()
export class SportService extends CrudBaseService<ISport> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/sports');
  }
}
