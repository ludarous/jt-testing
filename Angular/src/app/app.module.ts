import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import {EventService} from './services/event.service';
import {CrudBaseService} from './services/crud-base.service';
import {HTTP_INTERCEPTORS, HttpClientModule} from '@angular/common/http';
import {AuthServerProvider} from './core/auth/auth-jwt.service';
import {AccountService} from './core/auth/account.service';
import {Principal} from './core/auth/principal.service';
import {StateStorageService} from './core/auth/state-storage.service';
import { LocalStorageService, SessionStorageService } from 'ngx-webstorage';
import {UserService} from './services/user.service';
import {AuthInterceptor} from './blocks/auth.interceptor';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: AuthInterceptor,
      multi: true,
      deps: [LocalStorageService, SessionStorageService]
    },
    EventService,
    AuthServerProvider,
    AccountService,
    Principal,
    StateStorageService,
    LocalStorageService,
    SessionStorageService,
    AuthServerProvider,
    UserService,
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
