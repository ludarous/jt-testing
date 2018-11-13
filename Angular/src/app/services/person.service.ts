import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {IActivity} from '../entities/activity';
import {IAddress} from '../entities/address';
import {IPerson} from '../entities/person';
import {Observable} from 'rxjs';

@Injectable()
export class PersonService extends CrudBaseService<IPerson> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/people');
  }

  findByUserId(userId: string | number): Observable<HttpResponse<IPerson>> {
    return this.httpClient.get<IPerson>(`${this.resourceUrl}/by-user-id/${userId}`, { observe: 'response' });
  }
}
