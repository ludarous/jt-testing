import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders, HttpResponse} from '@angular/common/http';
import {Observable} from 'rxjs';
import {enterView} from '@angular/core/src/render3/instructions';
import {environment} from '../../../environments/environment';
import {AuthServerProvider} from './auth-jwt.service';

@Injectable({providedIn: 'root'})
export class AccountService {
  constructor(private http: HttpClient) {
  }

  get(): Observable<HttpResponse<Account>> {
    return this.http.get<Account>(environment.backendUrl + '/account', {observe: 'response'});
  }

  save(account: any): Observable<HttpResponse<any>> {
    return this.http.post(environment.backendUrl + '/account', account, {observe: 'response'});
  }

  resetPasswordInit(mail: string): Observable<HttpResponse<any>> {
    return this.http.post(environment.backendUrl + '/account/reset-password/init', mail, {observe: 'response'});
  }
}
