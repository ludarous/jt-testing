import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import {environment} from '../../environments/environment';
import {createRequestOption} from '../utils/request-util';


@Injectable({ providedIn: 'root' })
export class UserService<T> {
  private readonly resourceUrl;

  constructor(private http: HttpClient, apiUrl: string) {
    this.resourceUrl = environment.backendUrl + apiUrl;
  }

  create(entity: T): Observable<HttpResponse<T>> {
    return this.http.post<T>(this.resourceUrl, entity, { observe: 'response' });
  }

  update(entity: T): Observable<HttpResponse<T>> {
    return this.http.put<T>(this.resourceUrl, entity, { observe: 'response' });
  }

  find(key: string | number): Observable<HttpResponse<T>> {
    return this.http.get<T>(`${this.resourceUrl}/${key}`, { observe: 'response' });
  }

  query(req?: any): Observable<HttpResponse<T[]>> {
    const options = createRequestOption(req);
    return this.http.get<T[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(login: string): Observable<HttpResponse<any>> {
    return this.http.delete(`${this.resourceUrl}/${login}`, { observe: 'response' });
  }

  authorities(): Observable<string[]> {
    return this.http.get<string[]>(environment.backendUrl + 'api/users/authorities');
  }
}
