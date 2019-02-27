import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AccountRoutingModule } from './account-routing.module';
import { LoginComponent } from './login/login.component';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {TranslateModule} from '@ngx-translate/core';
import { RegisterComponent } from './register/register.component';
import { ProfileComponent } from './profile/profile.component';
import {AddressService} from '../services/address.service';
import {UserService} from '../services/user.service';
import {PersonService} from '../services/person.service';
import {PersonalDataService} from '../services/personal-data.service';
import {PrimeNgComponentsModule} from '../@theme/modules/primeng/primeng-components.module';
import {EnumTranslationsModule} from '../@theme/modules/enum-translator/enum-translations.module';
import {NbAlertModule, NbCheckboxModule, NbThemeModule} from '@nebular/theme';
import {AccountComponent} from './account.component';
import {ThemeModule} from '../@theme/theme.module';
import {NbAuthModule} from '@nebular/auth';
import {LogoutComponent} from './logout/logout.component';
import {NbMomentDateModule} from '@nebular/moment';


@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    EnumTranslationsModule,
    AccountRoutingModule,
    NbAlertModule,
    NbCheckboxModule,
    ThemeModule,
    NbAuthModule,
    NbMomentDateModule,
  ],
  providers: [
    UserService,
    PersonService,
    PersonalDataService,
    AddressService,
  ],
  declarations: [
    AccountComponent,
    LoginComponent,
    LogoutComponent,
    RegisterComponent,
    ProfileComponent
  ],
  exports: [
    LoginComponent,
    RegisterComponent
  ]
})
export class AccountModule { }
