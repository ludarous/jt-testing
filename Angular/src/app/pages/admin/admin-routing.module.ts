import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {AdminComponent} from './admin.component';

const routes: Routes = [
  {
    path: '',
    component: AdminComponent,
    children: [
      {
        path: '',
        redirectTo: 'activities'
      },
      {
        path: 'activity-categories',
        loadChildren: 'app/pages/admin/activity-categories/activity-categories.module#ActivityCategoriesModule',
      },
      {
        path: 'activities',
        loadChildren: 'app/pages/admin/activities/activities.module#ActivitiesModule',
      },
      {
        path: 'activity-group-categories',
        loadChildren: 'app/pages/admin/activity-group-categories/activity-group-categories.module#ActivityGroupCategoriesModule',
      },
      {
        path: 'activity-groups',
        loadChildren: 'app/pages/admin/activity-groups/activity-groups.module#ActivityGroupsModule',
      },
      {
        path: 'events',
        loadChildren: 'app/pages/admin/events/events.module#EventsModule',
      },
      {
        path: 'results',
        loadChildren: 'app/pages/admin/results/results.module#ResultsModule',
      },
      {
        path: 'users',
        loadChildren: 'app/pages/admin/users/users.module#UsersModule',
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdminRoutingModule { }
