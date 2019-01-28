import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {DashboardComponent} from './dashboard/dashboard.component';

const routes: Routes = [
  {
    path: 'dashboard',
    component: DashboardComponent
  },
  {
    path: 'my-results',
    loadChildren: 'app/pages/user/results/user-results.module#UserResultsModule',
  },
  {
    path: 'my-stats',
    loadChildren: 'app/pages/user/stats/user-stats.module#UserStatsModule',
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UserRoutingModule { }
