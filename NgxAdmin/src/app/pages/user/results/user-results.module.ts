import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserResultsRoutingModule } from './user-results-routing.module';
import { UserResultsComponent } from './user-results.component';
import {EventResultService} from '../../../services/event-result.service';
import {EventService} from '../../../services/event.service';
import { UserEventResultComponent } from '../components/results/user-event-result/user-event-result.component';
import { UserWorkoutResultComponent } from '../components/results/user-workout-result/user-workout-result.component';
import { UserActivityResultComponent } from '../components/results/user-activity-result/user-activity-result.component';
import {ActivityService} from '../../../services/activity.service';
import {
  BarChartModule,
  BarHorizontal2DComponent,
  ChartCommonModule, GaugeModule,
  LinearGaugeComponent,
  LineChartModule,
  NumberCardModule, PolarChartModule
} from '@swimlane/ngx-charts';
import {ActivityCategoryService} from '../../../services/activity-category.service';
import {WorkoutService} from '../../../services/workout.service';
import {StatsService} from '../../../services/stats.service';
import {EnumTranslationsModule} from '../../../@theme/modules/enum-translator/enum-translations.module';
import {ThemeModule} from '../../../@theme/theme.module';

@NgModule({
  declarations: [
    UserResultsComponent,
  ],
  imports: [
    CommonModule,
    UserResultsRoutingModule,
    EnumTranslationsModule,
    ChartCommonModule,
    BarChartModule,
    LineChartModule,
    NumberCardModule,
    GaugeModule,
    PolarChartModule,
    ThemeModule
  ],
  providers: [
    EventResultService,
    EventService,
    ActivityService,
    ActivityCategoryService,
    WorkoutService,
    StatsService,
  ],
  exports: [
    UserResultsComponent,
  ]
})
export class UserResultsModule { }
