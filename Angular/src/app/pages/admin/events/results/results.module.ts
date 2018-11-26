import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ResultsRoutingModule } from './results-routing.module';
import {ResultsComponent} from './results.component';
import {EventResultEditComponent} from './event-result-edit/event-result-edit.component';
import {TestResultEditComponent} from './test-result-edit/test-result-edit.component';
import {ActivityResultEditComponent} from './activity-result-edit/activity-result-edit.component';
import {MaterialComponentsModule} from '../../../../shared/material-components.module';
import {PrimeNgComponentsModule} from '../../../../shared/primeng-components.module';
import {TranslateModule} from '@ngx-translate/core';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {EventResultService} from '../../../../services/event-result.service';
import {EnumTranslationsModule} from '../../../../shared/pipes/enum-translator/enum-translations.module';

@NgModule({
  declarations: [
    ResultsComponent,
    EventResultEditComponent,
    TestResultEditComponent,
    ActivityResultEditComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    ResultsRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    EnumTranslationsModule,
  ],
  providers: [
    EventResultService,
  ]
})
export class ResultsModule { }
