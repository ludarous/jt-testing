import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AdminRoutingModule } from './admin-routing.module';
import { WorkoutsComponent } from './workouts/workouts.component';
import {AdminComponent} from './admin.component';
import {ActivityService} from '../../services/activity.service';
import {ActivitiesModule} from './activities/activities.module';
import {ActivityCategoryService} from '../../services/activity-category.service';
import {SportService} from '../../services/sport.service';
import {UserService} from '../../services/user.service';
import {PersonService} from '../../services/person.service';
import {PersonalDataService} from '../../services/personal-data.service';
import {AddressService} from '../../services/address.service';
import {EventService} from '../../services/event.service';
import {ActivityCategoriesModule} from './activity-categories/activity-categories.module';
import {WorkoutService} from '../../services/workout.service';
import {WorkoutCategoryService} from '../../services/workout-category.service';
import {PrimeNgComponentsModule} from '../../@theme/modules/primeng/primeng-components.module';
import {ThemeModule} from '../../@theme/theme.module';


@NgModule({
  declarations:
    [
      AdminComponent,
    ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    PrimeNgComponentsModule,

    ActivitiesModule,
    ActivityCategoriesModule,

  ],
  providers: [
    EventService,
    ActivityService,
    WorkoutService,
    SportService,
    UserService,
    PersonService,
    PersonalDataService,
    AddressService,
    ActivityCategoryService,
    WorkoutCategoryService,
  ],
})
export class AdminModule { }
