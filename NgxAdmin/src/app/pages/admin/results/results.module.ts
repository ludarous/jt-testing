import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ResultsRoutingModule } from './results-routing.module';
import {ResultsComponent} from './results.component';
import {EventResultEditComponent} from './event-result-edit/event-result-edit.component';
import {WorkoutResultEditComponent} from './workout-result-edit/workout-result-edit.component';
import {ActivityResultEditComponent} from './activity-result-edit/activity-result-edit.component';
import {TranslateModule} from '@ngx-translate/core';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {EventResultService} from '../../../services/event-result.service';
import {PrimeNgComponentsModule} from '../../../@theme/modules/primeng/primeng-components.module';
import {EnumTranslationsModule} from '../../../@theme/modules/enum-translator/enum-translations.module';
import {ThemeModule} from '../../../@theme/theme.module';
import { EventResultsComponent } from './event-results/event-results.component';
import {ActivityResultService} from '../../../services/activity-result.service';

const COMPONENTS = [
  ResultsComponent,
  EventResultEditComponent,
  WorkoutResultEditComponent,
  ActivityResultEditComponent,
  EventResultsComponent,
];

@NgModule({
  declarations: [
    COMPONENTS
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    ResultsRoutingModule,
    PrimeNgComponentsModule,
    TranslateModule,
    EnumTranslationsModule,
    ThemeModule,
  ],
  providers: [
    EventResultService,
    ActivityResultService,
  ],
  exports: [
    COMPONENTS
  ]
})
export class ResultsModule { }
