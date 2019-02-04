import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {TranslateModule} from '@ngx-translate/core';
import {SharedModule} from '../../../shared/shared.module';
import {NgMultiSelectDropDownModule} from 'ng-multiselect-dropdown';
import {WorkoutsComponent} from './workouts.component';
import {WorkoutsListComponent} from './list/workouts-list.component';
import {WorkoutsEditComponent} from './edit/workouts-edit.component';
import {WorkoutsRoutingModule} from './workouts-routing.module';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {PrimeNgComponentsModule} from '../../../shared/primeng-components.module';

@NgModule({
  declarations: [
    WorkoutsComponent,
    WorkoutsListComponent,
    WorkoutsEditComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    WorkoutsRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    SharedModule,
    NgMultiSelectDropDownModule
  ],
  exports: [
    WorkoutsComponent,
    WorkoutsListComponent,
    WorkoutsEditComponent,
  ]
})
export class WorkoutsModule { }
