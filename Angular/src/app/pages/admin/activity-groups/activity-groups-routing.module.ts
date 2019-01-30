import {NgModule} from '@angular/core';
import {Routes, RouterModule} from '@angular/router';
import {ActivityGroupsComponent} from './activity-groups.component';
import {ActivityGroupsListComponent} from './list/activity-groups-list.component';
import {ActivityGroupsEditComponent} from './edit/activity-groups-edit.component';

const routes: Routes = [
  {
    path: '',
    component: ActivityGroupsComponent,
    children: [
      {
        path: '',
        redirectTo: 'list'
      },
      {
        path: 'list',
        component: ActivityGroupsListComponent
      },
      {
        path: 'create',
        component: ActivityGroupsEditComponent
      },
      {
        path: 'edit/:id',
        component: ActivityGroupsEditComponent
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ActivityGroupsRoutingModule {
}
