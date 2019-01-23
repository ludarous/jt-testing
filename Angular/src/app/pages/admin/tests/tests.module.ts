import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {TranslateModule} from '@ngx-translate/core';
import {SharedModule} from '../../../shared/shared.module';
import {NgMultiSelectDropDownModule} from 'ng-multiselect-dropdown';
import {TestsComponent} from './tests.component';
import {TestsListComponent} from './list/tests-list.component';
import {TestsEditComponent} from './edit/tests-edit.component';
import {TestsRoutingModule} from './tests-routing.module';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {PrimeNgComponentsModule} from '../../../shared/primeng-components.module';

@NgModule({
  declarations: [
    TestsComponent,
    TestsListComponent,
    TestsEditComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    TestsRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    SharedModule,
    NgMultiSelectDropDownModule
  ],
  exports: [
    TestsComponent,
    TestsListComponent,
    TestsEditComponent,
  ]
})
export class TestsModule { }
