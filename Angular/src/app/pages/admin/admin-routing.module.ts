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
        component: ActivitiesComponent
      },
      {
        path: 'tests',
        component: TestsComponent
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
