import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable, throwError} from 'rxjs';
import {catchError, map} from 'rxjs/operators';
import {LocalStorageService, SessionStorageService} from 'ngx-webstorage';
import {environment} from '../../../environments/environment';
import {EventManager} from '../../services/event.manager';
import {IUser} from '../../entities/user';
import {Principal} from './principal.service';

@Injectable({providedIn: 'root'})
export class AuthServerProvider {
  constructor(private http: HttpClient,
              private $localStorage: LocalStorageService,
              private $sessionStorage: SessionStorageService,
              private eventManager: EventManager,
              private principal: Principal) {
  }

  getToken() {
    return this.$localStorage.retrieve('authenticationToken') || this.$sessionStorage.retrieve('authenticationToken');
  }

  login(credentials): Observable<any> {
    const data = {
      username: credentials.username,
      password: credentials.password,
      rememberMe: credentials.rememberMe
    };

    function authenticateSuccess(resp) {
      const bearerToken = resp.headers.get('Authorization');
      if (bearerToken && bearerToken.slice(0, 7) === 'Bearer ') {
        const jwt = bearerToken.slice(7, bearerToken.length);
        this.storeAuthenticationToken(jwt, true);
        this.eventManager.broadcast('authenticationSuccess');
        this.principal.identity(true);
        return jwt;
      }
    }

    return this.http.post(environment.backendUrl + '/authenticate', data, {observe: 'response'})
      .pipe(
        map(authenticateSuccess.bind(this),
          catchError((error, caught) => {
            return throwError(error);
      })));
  }

  register(account: IUser, confirmPassword: string): Observable<any> {
    if (account.password !== confirmPassword) {
      return throwError('Hesla se neshodují');
    } else {

      account.langKey = 'cz';
      return this.http.post(environment.backendUrl + '/register', account);
    }
  }

  loginWithToken(jwt, rememberMe) {
    if (jwt) {
      this.storeAuthenticationToken(jwt, rememberMe);
      return Promise.resolve(jwt);
    } else {
      return Promise.reject('auth-jwt-service Promise reject'); // Put appropriate error message here
    }
  }

  storeAuthenticationToken(jwt, rememberMe) {
    if (rememberMe) {
      this.$localStorage.store('authenticationToken', jwt);
    } else {
      this.$sessionStorage.store('authenticationToken', jwt);
    }
  }

  logout() {
    this.$localStorage.clear('authenticationToken');
    this.$sessionStorage.clear('authenticationToken');
    this.eventManager.broadcast({
      name: 'logoutSuccess',
      content: 'Sending Logout Success'
    });
    this.principal.authenticate(null);
  }
}