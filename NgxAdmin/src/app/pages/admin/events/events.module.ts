import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {TranslateModule} from '@ngx-translate/core';
import {EventsComponent} from './events.component';
import {EventListComponent} from './list/event-list.component';
import {EventEditComponent} from './edit/event-edit.component';
import {EventsRoutingModule} from './events-routing.module';
import {ResultsModule} from '../results/results.module';
import {PrimeNgComponentsModule} from '../../../@theme/modules/primeng/primeng-components.module';
import {EnumTranslationsModule} from '../../../@theme/modules/enum-translator/enum-translations.module';
import {ThemeModule} from '../../../@theme/theme.module';

@NgModule({
  declarations: [
    EventsComponent,
    EventListComponent,
    EventEditComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    EventsRoutingModule,
    PrimeNgComponentsModule,
    TranslateModule,
    ResultsModule,
    EnumTranslationsModule,
    ThemeModule,
    ResultsModule,
  ],
  exports: [
    EventsComponent,
    EventListComponent,
    EventEditComponent,
  ],
})
export class EventsModule { }
