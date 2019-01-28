import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserRoutingModule } from './user-routing.module';
import {DashboardComponent} from './dashboard/dashboard.component';
import {PrimeNgComponentsModule} from '../../shared/primeng-components.module';
import {EventService} from '../../services/event.service';
import {FullCalendarModule} from 'primeng/fullcalendar';
import {BarChartModule, ChartCommonModule, GaugeModule, LineChartModule, NumberCardModule, PolarChartModule} from '@swimlane/ngx-charts';
import {StatsService} from '../../services/stats.service';

@NgModule({
  declarations: [
    DashboardComponent,
  ],
  imports: [
    CommonModule,
    UserRoutingModule,
    PrimeNgComponentsModule,
    FullCalendarModule,
    ChartCommonModule,
    PolarChartModule,
  ],
  providers: [
    EventService,
    StatsService
  ]
})
export class UserModule { }
