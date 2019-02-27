import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IWorkoutCategory} from '../entities/workout-category';

@Injectable()
export class WorkoutCategoryService extends CrudBaseService<IWorkoutCategory> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/workout-categories');
  }
}
