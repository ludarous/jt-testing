import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserStatsRoutingModule } from './user-stats-routing.module';
import { UserStatsComponent } from './user-stats.component';
import { EventResultService } from '../../../services/event-result.service';
import { ActivityService } from '../../../services/activity.service';
import { StatsService } from '../../../services/stats.service';
import { UserActivityStatsComponent } from '../components/stats/user-activity-stats/user-activity-stats.component';
import {
  AreaChartModule,
  BarChartModule,
  ChartCommonModule,
  GaugeModule,
  LineChartModule,
  NumberCardModule,
  PolarChartModule
} from '@swimlane/ngx-charts';
import { ThemeModule } from '../../../@theme/theme.module';
import { EnumTranslationsModule } from '../../../@theme/modules/enum-translator/enum-translations.module';

@NgModule({
  declarations: [
    UserStatsComponent,
    UserActivityStatsComponent,
  ],
  imports: [
    CommonModule,
    UserStatsRoutingModule,
    ChartCommonModule,
    PolarChartModule,
    LineChartModule,
    AreaChartModule,
    NumberCardModule,
    BarChartModule,
    GaugeModule,
    ThemeModule,
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
