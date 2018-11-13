import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient} from '@angular/common/http';
import {IActivity} from '../entities/activity';
import {IAddress} from '../entities/address';

@Injectable()
export class AddressService extends CrudBaseService<IAddress> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/addresses');
  }
}
