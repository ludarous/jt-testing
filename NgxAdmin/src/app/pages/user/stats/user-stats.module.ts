import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserStatsRoutingModule } from './user-stats-routing.module';
import { UserStatsComponent } from './user-stats.component';
import {EventResultService} from '../../../services/event-result.service';
import {ActivityService} from '../../../services/activity.service';
import {AreaChartModule, LineChartModule, NumberCardModule} from '@swimlane/ngx-charts';
import {StatsService} from '../../../services/stats.service';
import {EnumTranslationsModule} from '../../../@theme/modules/enum-translator/enum-translations.module';

@NgModule({
  declarations: [
    UserStatsComponent
  ],
  imports: [
    CommonModule,
    UserStatsRoutingModule,
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
