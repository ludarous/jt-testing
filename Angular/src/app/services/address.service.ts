import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient} from '@angular/common/http';
import {IAddress} from '../entities/address';

@Injectable()
export class AddressService extends CrudBaseService<IAddress> {
  constructor(httpClient: HttpClient) {
    super(httpClient, '/addresses');
  }
}
