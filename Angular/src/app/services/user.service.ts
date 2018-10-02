import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient} from '@angular/common/http';

@Injectable()
export class UserService extends CrudBaseService<IUser> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/users');
  }
}
