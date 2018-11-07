import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import {EventService} from './services/event.service';
import {CrudBaseService} from './services/crud-base.service';
import {HTTP_INTERCEPTORS, HttpClient, HttpClientModule} from '@angular/common/http';
import {AuthServerProvider} from './core/auth/auth-jwt.service';
import {AccountService} from './core/auth/account.service';
import {Principal} from './core/auth/principal.service';
import {StateStorageService} from './core/auth/state-storage.service';
import { LocalStorageService, SessionStorageService } from 'ngx-webstorage';
import {UserService} from './services/user.service';
import {AuthInterceptor} from './blocks/auth.interceptor';
import {AccountModule} from './pages/account/account.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {TranslateLoader, TranslateModule, TranslateService} from '@ngx-translate/core';
import {TranslateHttpLoader} from '@ngx-translate/http-loader';
import {AppRoutingModule} from './app-routing.module';
import {RouterModule} from '@angular/router';
import {CommonModule} from '@angular/common';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {SharedModule} from './shared/shared.module';
import {SharedComponentsModule} from './shared/components/shared-components.module';


export function createTranslateLoader(http: HttpClient) {
  return new TranslateHttpLoader(http, './assets/i18n/', '.json');
}

@NgModule({
  declarations: [
    AppComponent,
  ],
  imports: [
    BrowserAnimationsModule,
    HttpClientModule,
    SharedComponentsModule,
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: (createTranslateLoader),
        deps: [HttpClient]
      }
    }),
    AppRoutingModule
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
