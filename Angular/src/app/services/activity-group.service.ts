import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IActivityGroup} from '../entities/activity-group';
import {IActivityGroupCategory} from '../entities/activity-group-category';

@Injectable()
export class ActivityGroupService extends CrudBaseService<IActivityGroup> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/activity-groups');
  }
}
