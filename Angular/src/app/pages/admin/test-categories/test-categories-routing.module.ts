import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {TestCategoriesEditComponent} from './edit/test-categories-edit.component';
import {TestCategoriesListComponent} from './list/test-categories-list.component';
import {TestCategoriesComponent} from './test-categories.component';

const routes: Routes = [
  {
    path: '',
    component: TestCategoriesComponent,
    children: [
      {
        path: '',
        redirectTo: 'list'
      },
      {
        path: 'list',
        component: TestCategoriesListComponent
      },
      {
        path: 'create',
        component: TestCategoriesEditComponent
      },
      {
        path: 'edit/:id',
        component: TestCategoriesEditComponent
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TestCategoriesRoutingModule { }
