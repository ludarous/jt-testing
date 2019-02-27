import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivityCategoriesRoutingModule } from './activity-categories-routing.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {TranslateModule} from '@ngx-translate/core';
import {ActivityCategoriesListComponent} from './list/activity-categories-list.component';
import {ActivityCategoriesEditComponent} from './edit/activity-categories-edit.component';
import {ActivityCategoriesComponent} from './activity-categories.component';
import {PrimeNgComponentsModule} from '../../../@theme/modules/primeng/primeng-components.module';
import {ThemeModule} from '../../../@theme/theme.module';

@NgModule({
  declarations: [
    ActivityCategoriesComponent,
    ActivityCategoriesListComponent,
    ActivityCategoriesEditComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    ActivityCategoriesRoutingModule,
    PrimeNgComponentsModule,
    TranslateModule,
    ThemeModule
  ],
  exports: [
    ActivityCategoriesComponent,
    ActivityCategoriesListComponent,
    ActivityCategoriesEditComponent,
  ],
})
export class ActivityCategoriesModule { }
