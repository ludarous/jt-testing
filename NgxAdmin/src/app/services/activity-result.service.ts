import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IActivityResult} from '../entities/activity-result';

@Injectable()
export class ActivityResultService extends CrudBaseService<IActivityResult> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/activity-results');
  }

}
