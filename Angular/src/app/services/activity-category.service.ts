import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IActivityCategory} from '../entities/activity-category';

@Injectable()
export class ActivityCategoryService extends CrudBaseService<IActivityCategory> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/activity-categories');
  }
}
