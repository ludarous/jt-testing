import {NgModule} from '@angular/core';
import {Routes, RouterModule} from '@angular/router';
import {TestsComponent} from './tests.component';
import {TestsListComponent} from './list/tests-list.component';
import {TestsEditComponent} from './edit/tests-edit.component';

const routes: Routes = [
  {
    path: '',
    component: TestsComponent,
    children: [
      {
        path: '',
        redirectTo: 'list'
      },
      {
        path: 'list',
        component: TestsListComponent
      },
      {
        path: 'create',
        component: TestsEditComponent
      },
      {
        path: 'edit/:id',
        component: TestsEditComponent
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TestsRoutingModule {
}
