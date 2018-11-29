import {NgModule} from '@angular/core';
import {Routes, RouterModule} from '@angular/router';
import {UsersComponent} from './users.component';
import {UsersListComponent} from './list/users-list.component';
import {PersonEditComponent} from './person-edit/person-edit.component';

const routes: Routes = [
  {
    path: '',
    component: UsersComponent,
    children: [
      {
        path: '',
        redirectTo: 'person-list'
      },
      {
        path: 'person-list',
        component: UsersListComponent
      },
      {
        path: 'person-edit/:id',
        component: PersonEditComponent
      },
      {
        path: 'person-edit',
        component: PersonEditComponent
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UsersRoutingModule {
}
