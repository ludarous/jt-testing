import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {UserResultsComponent} from './user-results.component';

const routes: Routes = [
  {
    path: '',
    component: UserResultsComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UserResultsRoutingModule { }
