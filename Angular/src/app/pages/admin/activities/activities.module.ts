import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ActivitiesRoutingModule } from './activities-routing.module';
import { ActivitiesComponent } from './activities.component';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {PrimeNgComponentsModule} from '../../../shared/primeng-components.module';
import {ActivitiesListComponent} from './list/activities-list.component';
import {ActivitiesEditComponent} from './edit/activities-edit.component';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {TranslateModule} from '@ngx-translate/core';
import {SharedModule} from '../../../shared/shared.module';
import {NgMultiSelectDropDownModule} from 'ng-multiselect-dropdown';
import { CategoriesComponent } from './categories/categories.component';

@NgModule({
  declarations: [
    ActivitiesComponent,
    ActivitiesListComponent,
    ActivitiesEditComponent,
    CategoriesComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    ActivitiesRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    SharedModule,
    NgMultiSelectDropDownModule
  ],
  exports: [
    ActivitiesComponent,
    ActivitiesListComponent,
    ActivitiesEditComponent,
  ]
})
export class ActivitiesModule { }
