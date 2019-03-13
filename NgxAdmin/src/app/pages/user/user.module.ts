import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserRoutingModule } from './user-routing.module';
import {DashboardComponent} from './dashboard/dashboard.component';
import {EventService} from '../../services/event.service';
import {FullCalendarModule} from 'primeng/fullcalendar';
import {
  AreaChartModule,
  BarChartModule,
  ChartCommonModule,
  GaugeModule,
  LineChartModule,
  NumberCardModule,
  PolarChartModule
} from '@swimlane/ngx-charts';
import {StatsService} from '../../services/stats.service';
import {PrimeNgComponentsModule} from '../../@theme/modules/primeng/primeng-components.module';
import { UserActivityStatsComponent } from './components/stats/user-activity-stats/user-activity-stats.component';
import { UserActivityResultComponent } from './components/results/user-activity-result/user-activity-result.component';
import { UserWorkoutResultComponent } from './components/results/user-workout-result/user-workout-result.component';
import { UserEventResultComponent } from './components/results/user-event-result/user-event-result.component';
import { EnumTranslationsModule } from '../../@theme/modules/enum-translator/enum-translations.module';
import { ThemeModule } from '../../@theme/theme.module';

@NgModule({
  declarations: [
    DashboardComponent,

    // Components
    UserActivityStatsComponent,
    UserActivityResultComponent,
    UserWorkoutResultComponent,
    UserEventResultComponent,
  ],
  imports: [
    CommonModule,
    UserRoutingModule,
    PrimeNgComponentsModule,
    FullCalendarModule,
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
    EventService,
    StatsService
  ],
  exports: [
    UserActivityStatsComponent,
    UserActivityResultComponent,
    UserWorkoutResultComponent,
    UserEventResultComponent,
  ]
})
export class UserModule { }
