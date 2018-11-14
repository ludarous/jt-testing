import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {IUser} from '../entities/user';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {IActivity} from '../entities/activity';
import {IAddress} from '../entities/address';
import {IPerson} from '../entities/person';
import {Observable} from 'rxjs';
import {IPersonFull, PersonFull} from '../entities/person-full';

@Injectable()
export class PersonService extends CrudBaseService<IPerson> {
  constructor(private httpClient: HttpClient) {
    super(httpClient, '/people');
  }

  findByUserId(userId: string | number): Observable<HttpResponse<IPerson>> {
    return this.httpClient.get<IPerson>(`${this.resourceUrl}/by-user-id/${userId}`, { observe: 'response' });
  }

  saveFull(personFull: IPersonFull): Observable<HttpResponse<IPersonFull>> {
    return this.httpClient.post<IPerson>(`${this.resourceUrl}/full`, personFull, { observe: 'response' });
  }

  findFull(personId: string | number): Observable<HttpResponse<IPersonFull>> {
    return this.httpClient.get<IPersonFull>(`${this.resourceUrl}/full/${personId}`, { observe: 'response' });
  }
}
