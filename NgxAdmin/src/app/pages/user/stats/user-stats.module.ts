import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserStatsRoutingModule } from './user-stats-routing.module';
import { UserStatsComponent } from './user-stats.component';
import {EventResultService} from '../../../services/event-result.service';
import {ActivityService} from '../../../services/activity.service';
import {AreaChartModule, LineChartModule, NumberCardModule} from '@swimlane/ngx-charts';
import { UserActivityStatsComponent } from './user-activity-stats/user-activity-stats.component';
import {StatsService} from '../../../services/stats.service';
import {EnumTranslationsModule} from '../../../@theme/modules/enum-translator/enum-translations.module';

@NgModule({
  declarations: [UserStatsComponent, UserActivityStatsComponent],
  imports: [
    CommonModule,
    UserStatsRoutingModule,
    LineChartModule,
    AreaChartModule,
    NumberCardModule,
    EnumTranslationsModule,
  ],
  providers: [
    EventResultService,
    ActivityService,
    StatsService,
  ],
  exports: [
    UserStatsComponent
  ]
})
export class UserStatsModule { }
