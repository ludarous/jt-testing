import {Injectable} from '@angular/core';
import {CrudBaseService} from './crud-base.service';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {IPerson} from '../entities/person';
import {Observable} from 'rxjs';
import {IPersonFull} from '../entities/person-full';
import {createRequestOption} from '../utils/request-util';

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

  updateFull(personFull: IPersonFull): Observable<HttpResponse<IPersonFull>> {
    return this.httpClient.put<IPerson>(`${this.resourceUrl}/full`, personFull, { observe: 'response' });
  }

  findFull(personId: string | number): Observable<HttpResponse<IPersonFull>> {
    return this.httpClient.get<IPersonFull>(`${this.resourceUrl}/full/${personId}`, { observe: 'response' });
  }

  queryFull(req?: any): Observable<HttpResponse<IPersonFull[]>> {
    const options = createRequestOption(req);
    return this.httpClient.get<IPersonFull[]>(`${this.resourceUrl}/full/`, { params: options, observe: 'response' });
  }
}
