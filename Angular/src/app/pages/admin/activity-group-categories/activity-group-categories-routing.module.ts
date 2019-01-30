import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {ActivityGroupCategoriesEditComponent} from './edit/activity-group-categories-edit.component';
import {ActivityGroupCategoriesListComponent} from './list/activity-group-categories-list.component';
import {ActivityGroupCategoriesComponent} from './activity-group-categories.component';

const routes: Routes = [
  {
    path: '',
    component: ActivityGroupCategoriesComponent,
    children: [
      {
        path: '',
        redirectTo: 'list'
      },
      {
        path: 'list',
        component: ActivityGroupCategoriesListComponent
      },
      {
        path: 'create',
        component: ActivityGroupCategoriesEditComponent
      },
      {
        path: 'edit/:id',
        component: ActivityGroupCategoriesEditComponent
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ActivityGroupCategoriesRoutingModule { }
