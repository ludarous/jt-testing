import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient} from '@angular/common/http';
import {IActivity} from '../entities/activity';
import {IPersonalData} from '../entities/personal-data';

@Injectable()
export class PersonalDataService extends CrudBaseService<IPersonalData> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/personal-data');
  }
}
