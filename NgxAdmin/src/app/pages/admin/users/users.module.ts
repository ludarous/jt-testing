import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {UsersComponent} from './users.component';
import {UsersListComponent} from './list/users-list.component';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {UsersRoutingModule} from './users-routing.module';
import {TranslateModule} from '@ngx-translate/core';
import {PersonEditComponent} from './person-edit/person-edit.component';
import {PrimeNgComponentsModule} from '../../../@theme/modules/primeng/primeng-components.module';
import {ThemeModule} from '../../../@theme/theme.module';


@NgModule({
  declarations: [
    UsersComponent,
    UsersListComponent,
    PersonEditComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    UsersRoutingModule,
    PrimeNgComponentsModule,
    TranslateModule,
    ThemeModule,
  ],
  exports: [
    UsersComponent,
    UsersListComponent,
    PersonEditComponent,
  ]
})
export class UsersModule { }
