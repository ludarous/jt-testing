import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {UsersComponent} from './users.component';
import {UsersListComponent} from './list/users-list.component';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {UsersRoutingModule} from './users-routing.module';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {NgMultiSelectDropDownModule} from 'ng-multiselect-dropdown';
import {TranslateModule} from '@ngx-translate/core';
import {SharedModule} from '../../../shared/shared.module';
import {PrimeNgComponentsModule} from '../../../shared/primeng-components.module';
import {PersonEditComponent} from './person-edit/person-edit.component';
import {NgxMaterialTimepickerModule} from 'ngx-material-timepicker';


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
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    SharedModule,
    NgMultiSelectDropDownModule,
    NgxMaterialTimepickerModule
  ],
  exports: [
    UsersComponent,
    UsersListComponent,
    PersonEditComponent,
  ]
})
export class UsersModule { }
