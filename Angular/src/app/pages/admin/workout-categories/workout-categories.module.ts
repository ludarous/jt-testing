import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { WorkoutCategoriesRoutingModule } from './workout-categories-routing.module';
import { WorkoutCategoriesComponent } from './workout-categories.component';
import { WorkoutCategoriesEditComponent } from './edit/workout-categories-edit.component';
import { WorkoutCategoriesListComponent } from './list/workout-categories-list.component';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {PrimeNgComponentsModule} from '../../../shared/primeng-components.module';
import {TranslateModule} from '@ngx-translate/core';
import {SharedModule} from '../../../shared/shared.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';

@NgModule({
  declarations: [
    WorkoutCategoriesComponent,
    WorkoutCategoriesEditComponent,
    WorkoutCategoriesListComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    WorkoutCategoriesRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    SharedModule
  ],
  exports: [
    WorkoutCategoriesComponent,
    WorkoutCategoriesEditComponent,
    WorkoutCategoriesListComponent
  ]
})
export class WorkoutCategoriesModule { }
