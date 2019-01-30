import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {TranslateModule} from '@ngx-translate/core';
import {SharedModule} from '../../../shared/shared.module';
import {NgMultiSelectDropDownModule} from 'ng-multiselect-dropdown';
import {ActivityGroupsComponent} from './activity-groups.component';
import {ActivityGroupsListComponent} from './list/activity-groups-list.component';
import {ActivityGroupsEditComponent} from './edit/activity-groups-edit.component';
import {ActivityGroupsRoutingModule} from './activity-groups-routing.module';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {PrimeNgComponentsModule} from '../../../shared/primeng-components.module';

@NgModule({
  declarations: [
    ActivityGroupsComponent,
    ActivityGroupsListComponent,
    ActivityGroupsEditComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    ActivityGroupsRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
    SharedModule,
    NgMultiSelectDropDownModule
  ],
  exports: [
    ActivityGroupsComponent,
    ActivityGroupsListComponent,
    ActivityGroupsEditComponent,
  ]
})
export class ActivityGroupsModule { }
