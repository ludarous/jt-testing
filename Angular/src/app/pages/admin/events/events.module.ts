import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {TranslateModule} from '@ngx-translate/core';
import {SharedModule} from '../../../shared/shared.module';
import {NgMultiSelectDropDownModule} from 'ng-multiselect-dropdown';
import {EventsComponent} from './events.component';
import {EventListComponent} from './list/event-list.component';
import {TestCategoriesComponent} from '../tests/categories/test-categories.component';
import {EventEditComponent} from './edit/event-edit.component';
import {EventsRoutingModule} from './events-routing.module';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {PrimeNgComponentsModule} from '../../../shared/primeng-components.module';


@NgModule({
  declarations: [
    EventsComponent,
    EventListComponent,
    EventEditComponent,
    TestCategoriesComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    EventsRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    SharedModule,
    NgMultiSelectDropDownModule
  ],
  exports: [
    EventsComponent,
    EventListComponent,
    EventEditComponent,
  ]
})
export class EventsModule { }
