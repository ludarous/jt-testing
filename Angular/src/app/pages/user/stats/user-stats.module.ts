import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserStatsRoutingModule } from './user-stats-routing.module';
import { UserStatsComponent } from './user-stats.component';
import {EventResultService} from '../../../services/event-result.service';
import {ActivityService} from '../../../services/activity.service';
import {LineChartModule, NumberCardModule} from '@swimlane/ngx-charts';
import { UserActivityStatsComponent } from './user-activity-stats/user-activity-stats.component';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {EnumTranslationsModule} from '../../../shared/pipes/enum-translator/enum-translations.module';

@NgModule({
  declarations: [UserStatsComponent, UserActivityStatsComponent],
  imports: [
    CommonModule,
    MaterialComponentsModule,
    UserStatsRoutingModule,
    LineChartModule,
    NumberCardModule,
    EnumTranslationsModule,
  ],
  providers: [
    EventResultService,
    ActivityService
  ],
  exports: [
    UserStatsComponent
  ]
})
export class UserStatsModule { }
