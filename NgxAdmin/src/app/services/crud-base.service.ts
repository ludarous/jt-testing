import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import {environment} from '../../environments/environment';
import {createRequestOption} from '../@core/utils/request-util';

export class CrudBaseService<T> {
  readonly resourceUrl;

  constructor(private http: HttpClient, apiUrl: string) {
    this.resourceUrl = environment.backendUrl + apiUrl;
  }

  create(entity: T): Observable<HttpResponse<T>> {
    return this.http.post<T>(this.resourceUrl, entity, { observe: 'response' });
  }

  update(entity: T): Observable<HttpResponse<T>> {
    return this.http.put<T>(this.resourceUrl, entity, { observe: 'response' });
  }

  find(id: string | number): Observable<HttpResponse<T>> {
    return this.http.get<T>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<HttpResponse<T[]>> {
    const options = createRequestOption(req);
    return this.http.get<T[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: string | number): Observable<HttpResponse<any>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  authorities(): Observable<string[]> {
    return this.http.get<string[]>(environment.backendUrl + '/users/authorities');
  }
}
