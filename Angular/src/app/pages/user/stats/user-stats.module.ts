import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserStatsRoutingModule } from './user-stats-routing.module';
import { UserStatsComponent } from './user-stats.component';
import {EventResultService} from '../../../services/event-result.service';

@NgModule({
  declarations: [UserStatsComponent],
  imports: [
    CommonModule,
    UserStatsRoutingModule
  ],
  providers: [
    EventResultService
  ],
  exports: [
    UserStatsComponent
  ]
})
export class UserStatsModule { }
