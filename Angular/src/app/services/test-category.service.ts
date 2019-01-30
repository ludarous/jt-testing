import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IActivityCategory} from '../entities/activity-category';
import {IActivityGroupCategory} from '../entities/activity-group-category';

@Injectable()
export class TestCategoryService extends CrudBaseService<IActivityGroupCategory> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/test-categories');
  }
}
