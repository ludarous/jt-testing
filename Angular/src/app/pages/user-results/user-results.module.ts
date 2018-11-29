import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserResultsRoutingModule } from './user-results-routing.module';
import { UserResultsComponent } from './user-results.component';
import {EventResultService} from '../../services/event-result.service';

@NgModule({
  declarations: [
    UserResultsComponent
  ],
  imports: [
    CommonModule,
    UserResultsRoutingModule
  ],
  providers: [
    EventResultService
  ],
  exports: [
    UserResultsComponent
  ]
})
export class UserResultsModule { }
