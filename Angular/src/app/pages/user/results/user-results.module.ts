import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserResultsRoutingModule } from './user-results-routing.module';
import { UserResultsComponent } from './user-results.component';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {EventResultService} from '../../../services/event-result.service';
import {EventService} from '../../../services/event.service';
import { UserEventResultComponent } from './user-event-result/user-event-result.component';
import { UserTestResultComponent } from './user-test-result/user-test-result.component';
import { UserActivityResultComponent } from './user-activity-result/user-activity-result.component';
import {ActivityService} from '../../../services/activity.service';

@NgModule({
  declarations: [
    UserResultsComponent,
    UserEventResultComponent,
    UserTestResultComponent,
    UserActivityResultComponent
  ],
  imports: [
    CommonModule,
    UserResultsRoutingModule,
    MaterialComponentsModule
  ],
  providers: [
    EventResultService,
    EventService,
    ActivityService,
  ],
  exports: [
    UserResultsComponent,
    UserEventResultComponent,
    UserTestResultComponent,
    UserActivityResultComponent
  ]
})
export class UserResultsModule { }
