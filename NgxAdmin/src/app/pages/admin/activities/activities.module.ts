import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ActivitiesRoutingModule } from './activities-routing.module';
import { ActivitiesComponent } from './activities.component';
import {ActivitiesListComponent} from './list/activities-list.component';
import {ActivitiesEditComponent} from './edit/activities-edit.component';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {PrimeNgComponentsModule} from '../../../@theme/modules/primeng/primeng-components.module';
import {TranslateModule} from '@ngx-translate/core';
import {EnumTranslationsModule} from '../../../@theme/modules/enum-translator/enum-translations.module';
import {ThemeModule} from '../../../@theme/theme.module';

@NgModule({
  declarations: [
    ActivitiesComponent,
    ActivitiesListComponent,
    ActivitiesEditComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    ActivitiesRoutingModule,
    PrimeNgComponentsModule,
    TranslateModule,
    EnumTranslationsModule,
    ThemeModule,
  ],
  exports: [
    ActivitiesComponent,
    ActivitiesListComponent,
    ActivitiesEditComponent,
  ],
})
export class ActivitiesModule { }
