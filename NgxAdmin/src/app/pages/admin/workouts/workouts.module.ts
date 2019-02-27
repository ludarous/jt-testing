import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {TranslateModule} from '@ngx-translate/core';
import {WorkoutsComponent} from './workouts.component';
import {WorkoutsListComponent} from './list/workouts-list.component';
import {WorkoutsEditComponent} from './edit/workouts-edit.component';
import {WorkoutsRoutingModule} from './workouts-routing.module';
import {PrimeNgComponentsModule} from '../../../@theme/modules/primeng/primeng-components.module';
import {ThemeModule} from '../../../@theme/theme.module';

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
    PrimeNgComponentsModule,
    TranslateModule,
    ThemeModule
  ],
  exports: [
    WorkoutsComponent,
    WorkoutsListComponent,
    WorkoutsEditComponent,
  ]
})
export class WorkoutsModule { }
