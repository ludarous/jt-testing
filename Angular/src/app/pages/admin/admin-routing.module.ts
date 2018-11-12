import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {AdminComponent} from './admin.component';
import {TestsComponent} from './tests/tests.component';
import {SessionsComponent} from './sessions/sessions.component';
import {ActivitiesListComponent} from './activities/list/activities-list.component';
import {ActivitiesComponent} from './activities/activities.component';

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
        path: 'activities',
        loadChildren: 'app/pages/admin/activities/activities.module#ActivitiesModule',
      },
      {
        path: 'tests',
        loadChildren: 'app/pages/admin/tests/tests.module#TestsModule',
      },
      {
        path: 'sessions',
        component: SessionsComponent
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdminRoutingModule { }
