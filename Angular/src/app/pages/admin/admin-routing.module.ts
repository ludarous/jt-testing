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
        path: 'tests',
        loadChildren: 'app/pages/admin/tests/tests.module#TestsModule',
      },
      {
        path: 'events',
        loadChildren: 'app/pages/admin/events/events.module#EventsModule',
      },
      {
        path: 'users',
        loadChildren: 'app/pages/admin/users/users.module#UsersModule',
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdminRoutingModule { }
