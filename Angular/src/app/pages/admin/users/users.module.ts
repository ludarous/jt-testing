import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {UsersComponent} from './users.component';
import {UsersListComponent} from './list/users-list.component';
import {UsersEditComponent} from './edit/users-edit.component';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {UsersRoutingModule} from './users-routing.module';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {NgMultiSelectDropDownModule} from 'ng-multiselect-dropdown';
import {TranslateModule} from '@ngx-translate/core';
import {SharedModule} from '../../../shared/shared.module';
import {PrimeNgComponentsModule} from '../../../shared/primeng-components.module';
import {PersonEditComponent} from './person-edit/person-edit.component';


@NgModule({
  declarations: [
    UsersComponent,
    UsersListComponent,
    UsersEditComponent,
    PersonEditComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    UsersRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    SharedModule,
    NgMultiSelectDropDownModule
  ],
  exports: [
    UsersComponent,
    UsersListComponent,
    UsersEditComponent,
    PersonEditComponent,
  ]
})
export class UsersModule { }
