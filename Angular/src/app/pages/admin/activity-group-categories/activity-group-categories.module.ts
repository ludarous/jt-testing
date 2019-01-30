import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ActivityGroupCategoriesRoutingModule } from './activity-group-categories-routing.module';
import { ActivityGroupCategoriesComponent } from './activity-group-categories.component';
import { ActivityGroupCategoriesEditComponent } from './edit/activity-group-categories-edit.component';
import { ActivityGroupCategoriesListComponent } from './list/activity-group-categories-list.component';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {PrimeNgComponentsModule} from '../../../shared/primeng-components.module';
import {TranslateModule} from '@ngx-translate/core';
import {SharedModule} from '../../../shared/shared.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';

@NgModule({
  declarations: [
    ActivityGroupCategoriesComponent,
    ActivityGroupCategoriesEditComponent,
    ActivityGroupCategoriesListComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    ActivityGroupCategoriesRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    SharedModule
  ],
  exports: [
    ActivityGroupCategoriesComponent,
    ActivityGroupCategoriesEditComponent,
    ActivityGroupCategoriesListComponent
  ]
})
export class ActivityGroupCategoriesModule { }
