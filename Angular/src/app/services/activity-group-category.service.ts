import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IActivityGroupCategory} from '../entities/activity-group-category';

@Injectable()
export class ActivityGroupCategoryService extends CrudBaseService<IActivityGroupCategory> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/activity-group-categories');
  }
}
