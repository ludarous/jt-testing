import {NgModule} from '@angular/core';
import {Routes, RouterModule} from '@angular/router';
import {AdminComponent} from '../admin.component';
import {ActivitiesListComponent} from './list/activities-list.component';
import {TestsComponent} from '../tests/tests.component';
import {SessionsComponent} from '../sessions/sessions.component';
import {ActivitiesComponent} from './activities.component';
import {ActivitiesEditComponent} from './edit/activities-edit.component';

const routes: Routes = [
  {
    path: '',
    component: ActivitiesComponent,
    children: [
      {
        path: '',
        redirectTo: 'list'
      },
      {
        path: 'list',
        component: ActivitiesListComponent
      },
      {
        path: 'create',
        component: ActivitiesEditComponent
      },
      {
        path: 'edit/:id',
        component: ActivitiesEditComponent
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ActivitiesRoutingModule {
}
