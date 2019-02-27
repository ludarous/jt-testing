import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {WorkoutCategoriesEditComponent} from './edit/workout-categories-edit.component';
import {WorkoutCategoriesListComponent} from './list/workout-categories-list.component';
import {WorkoutCategoriesComponent} from './workout-categories.component';

const routes: Routes = [
  {
    path: '',
    component: WorkoutCategoriesComponent,
    children: [
      {
        path: '',
        redirectTo: 'list'
      },
      {
        path: 'list',
        component: WorkoutCategoriesListComponent
      },
      {
        path: 'create',
        component: WorkoutCategoriesEditComponent
      },
      {
        path: 'edit/:id',
        component: WorkoutCategoriesEditComponent
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class WorkoutCategoriesRoutingModule { }
