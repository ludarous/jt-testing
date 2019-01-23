import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { TestCategoriesRoutingModule } from './test-categories-routing.module';
import { TestCategoriesComponent } from './test-categories.component';
import { TestCategoriesEditComponent } from './edit/test-categories-edit.component';
import { TestCategoriesListComponent } from './list/test-categories-list.component';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {PrimeNgComponentsModule} from '../../../shared/primeng-components.module';
import {TranslateModule} from '@ngx-translate/core';
import {SharedModule} from '../../../shared/shared.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';

@NgModule({
  declarations: [
    TestCategoriesComponent,
    TestCategoriesEditComponent,
    TestCategoriesListComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    TestCategoriesRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    SharedModule
  ],
  exports: [
    TestCategoriesComponent,
    TestCategoriesEditComponent,
    TestCategoriesListComponent
  ]
})
export class TestCategoriesModule { }
