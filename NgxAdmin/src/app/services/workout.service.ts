import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IWorkout} from '../entities/workout';
import {IWorkoutCategory} from '../entities/workout-category';

@Injectable()
export class WorkoutService extends CrudBaseService<IWorkout> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/workouts');
  }
}
