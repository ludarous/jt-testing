import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {UserResultsComponent} from './user-results.component';
import { UserEventResultComponent } from '../components/results/user-event-result/user-event-result.component';

const routes: Routes = [
  {
    path: '',
    component: UserResultsComponent,
  },
  {
    path: 'event/:id',
    component: UserEventResultComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UserResultsRoutingModule { }
