import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AdminRoutingModule } from './admin-routing.module';
import { ActivityGroupsComponent } from './activity-groups/activity-groups.component';
import {AdminComponent} from './admin.component';
import {MaterialComponentsModule} from '../../shared/material-components.module';
import {ActivityService} from '../../services/activity.service';
import {PrimeNgComponentsModule} from '../../shared/primeng-components.module';
import {ActivitiesModule} from './activities/activities.module';
import {ActivityCategoryService} from '../../services/activity-category.service';
import {SportService} from '../../services/sport.service';
import {UserService} from '../../services/user.service';
import {PersonService} from '../../services/person.service';
import {PersonalDataService} from '../../services/personal-data.service';
import {AddressService} from '../../services/address.service';
import {EventService} from '../../services/event.service';
import {ActivityCategoriesModule} from './activity-categories/activity-categories.module';
import {ActivityGroupService} from '../../services/activity-group.service';
import {ActivityGroupCategoryService} from '../../services/activity-group-category.service';


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
    ActivityCategoriesModule,
  ],
  providers: [
    EventService,
    ActivityService,
    ActivityGroupService,
    SportService,
    UserService,
    PersonService,
    PersonalDataService,
    AddressService,
    ActivityCategoryService,
    ActivityGroupCategoryService,

  ]
})
export class AdminModule { }
