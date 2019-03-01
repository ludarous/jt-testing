import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserResultsRoutingModule } from './user-results-routing.module';
import { UserResultsComponent } from './user-results.component';
import {MaterialComponentsModule} from '../../../shared/material-components.module';
import {EventResultService} from '../../../services/event-result.service';
import {EventService} from '../../../services/event.service';
import { UserEventResultComponent } from './user-event-result/user-event-result.component';
import { UserWorkoutResultComponent } from './user-workout-result/user-workout-result.component';
import { UserActivityResultComponent } from './user-activity-result/user-activity-result.component';
import {ActivityService} from '../../../services/activity.service';
import {EnumTranslationsModule} from '../../../shared/pipes/enum-translator/enum-translations.module';
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

@NgModule({
  declarations: [
    UserResultsComponent,
    UserEventResultComponent,
    UserWorkoutResultComponent,
    UserActivityResultComponent,
  ],
  imports: [
    CommonModule,
    UserResultsRoutingModule,
    MaterialComponentsModule,
    EnumTranslationsModule,
    ChartCommonModule,
    BarChartModule,
    LineChartModule,
    NumberCardModule,
    GaugeModule,
    PolarChartModule,
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
    UserEventResultComponent,
    UserWorkoutResultComponent,
    UserActivityResultComponent
  ]
})
export class UserResultsModule { }