import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IActivityCategory} from '../entities/activity-category';
import {ITestCategory} from '../entities/test-category';

@Injectable()
export class TestCategoryService extends CrudBaseService<ITestCategory> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/test-categories');
  }
}
