import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import {CrudBaseService} from './services/crud-base.service';
import {HTTP_INTERCEPTORS, HttpClient, HttpClientModule} from '@angular/common/http';
import {AuthServerProvider} from './core/auth/auth-jwt.service';
import {AccountService} from './core/auth/account.service';
import {Principal} from './core/auth/principal.service';
import {StateStorageService} from './core/auth/state-storage.service';
import {LocalStorageService, NgxWebstorageModule, SessionStorageService} from 'ngx-webstorage';
import {UserService} from './services/user.service';
import {AuthInterceptor} from './blocks/auth.interceptor';
import {TranslateLoader, TranslateModule} from '@ngx-translate/core';
import {TranslateHttpLoader} from '@ngx-translate/http-loader';
import {AppRoutingModule} from './app-routing.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {SharedComponentsModule} from './shared/components/shared-components.module';
import {NgMultiSelectDropDownModule} from 'ng-multiselect-dropdown';
import {EventManager} from './services/event.manager';


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
    NgxWebstorageModule.forRoot(),
    NgMultiSelectDropDownModule.forRoot(),
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
    EventManager,
    AuthServerProvider,
    AccountService,
    Principal,
    StateStorageService,
    AuthServerProvider,
    UserService,
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
