import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AdminRoutingModule } from './admin-routing.module';
import { TestsComponent } from './tests/tests.component';
import {AdminComponent} from './admin.component';
import {MaterialComponentsModule} from '../../shared/material-components.module';
import {ActivityService} from '../../services/activity.service';
import {PrimeNgComponentsModule} from '../../shared/primeng-components.module';
import {ActivitiesModule} from './activities/activities.module';
import {ActivityCategoryService} from '../../services/activity-category.service';
import {TestService} from '../../services/test.service';
import {SportService} from '../../services/sport.service';
import {TestCategoryService} from '../../services/test-category.service';
import {UserService} from '../../services/user.service';
import {PersonService} from '../../services/person.service';
import {PersonalDataService} from '../../services/personal-data.service';
import {AddressService} from '../../services/address.service';
import {EventService} from '../../services/event.service';


@NgModule({
  declarations:
    [
      AdminComponent,
    ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,

    ActivitiesModule,
  ],
  providers: [
    EventService,
    ActivityService,
    TestService,
    SportService,
    UserService,
    PersonService,
    PersonalDataService,
    AddressService,
    ActivityCategoryService,
    TestCategoryService,

  ]
})
export class AdminModule { }
