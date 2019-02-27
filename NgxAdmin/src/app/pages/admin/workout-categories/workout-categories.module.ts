import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { WorkoutCategoriesRoutingModule } from './workout-categories-routing.module';
import { WorkoutCategoriesComponent } from './workout-categories.component';
import { WorkoutCategoriesEditComponent } from './edit/workout-categories-edit.component';
import { WorkoutCategoriesListComponent } from './list/workout-categories-list.component';
import {TranslateModule} from '@ngx-translate/core';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {PrimeNgComponentsModule} from '../../../@theme/modules/primeng/primeng-components.module';
import {ThemeModule} from '../../../@theme/theme.module';

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
    PrimeNgComponentsModule,
    TranslateModule,
    ThemeModule
  ],
  exports: [
    WorkoutCategoriesComponent,
    WorkoutCategoriesEditComponent,
    WorkoutCategoriesListComponent
  ]
})
export class WorkoutCategoriesModule { }
