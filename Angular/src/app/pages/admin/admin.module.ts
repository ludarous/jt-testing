import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AdminRoutingModule } from './admin-routing.module';
import { TestsComponent } from './tests/tests.component';
import { SessionsComponent } from './sessions/sessions.component';
import {AdminComponent} from './admin.component';
import {MaterialComponentsModule} from '../../shared/material-components.module';
import {ActivityService} from '../../services/activity.service';
import {PrimeNgComponentsModule} from '../../shared/primeng-components.module';
import {ActivitiesListComponent} from './activities/list/activities-list.component';
import {ActivitiesEditComponent} from './activities/edit/activities-edit.component';


@NgModule({
  declarations:
    [
      AdminComponent,
      TestsComponent,
      SessionsComponent,
      ActivitiesListComponent,
      ActivitiesEditComponent,
    ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule
  ],
  providers: [
    ActivityService
  ]
})
export class AdminModule { }
