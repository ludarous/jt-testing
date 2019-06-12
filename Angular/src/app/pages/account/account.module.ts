import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AccountRoutingModule } from './account-routing.module';
import { LoginComponent } from './login/login.component';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {MaterialComponentsModule} from '../../shared/material-components.module';
import {SharedModule} from '../../shared/shared.module';
import {TranslateModule} from '@ngx-translate/core';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {PrimeNgComponentsModule} from '../../shared/primeng-components.module';
import { RegisterComponent } from './register/register.component';
import { ProfileComponent } from './profile/profile.component';
import {AddressService} from '../../services/address.service';
import {UserService} from '../../services/user.service';
import {PersonService} from '../../services/person.service';
import {PersonalDataService} from '../../services/personal-data.service';
import {EnumTranslationsModule} from '../../shared/pipes/enum-translator/enum-translations.module';
import {SharedComponentsModule} from '../../shared/components/shared-components.module';
import { RequestComponent } from './lost-password/request/request.component';
import { FinishComponent } from './lost-password/finish/finish.component';

@NgModule({
  imports: [
    CommonModule,
    SharedModule,
    FormsModule,
    ReactiveFormsModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    EnumTranslationsModule,
    AccountRoutingModule,
    SharedComponentsModule,
  ],
  providers: [
    UserService,
    PersonService,
    PersonalDataService,
    AddressService,
  ],
  declarations: [
    LoginComponent,
    RegisterComponent,
    ProfileComponent,
    RequestComponent,
    FinishComponent
  ],
  exports: [
    LoginComponent,
    RegisterComponent
  ]
})
export class AccountModule { }
