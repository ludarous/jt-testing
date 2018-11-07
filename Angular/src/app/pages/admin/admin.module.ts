import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AdminRoutingModule } from './admin-routing.module';
import { ActivitiesComponent } from './activities/activities.component';
import { TestsComponent } from './tests/tests.component';
import { SessionsComponent } from './sessions/sessions.component';
import {AdminComponent} from './admin.component';
import {MaterialComponentsModule} from '../../shared/material-components.module';

@NgModule({
  declarations:
    [
      AdminComponent,
      ActivitiesComponent,
      TestsComponent,
      SessionsComponent,
    ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    MaterialComponentsModule
  ]
})
export class AdminModule { }
