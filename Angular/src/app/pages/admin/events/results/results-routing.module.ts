import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {ResultsComponent} from './results.component';
import {EventResultEditComponent} from './event-result-edit/event-result-edit.component';

const routes: Routes = [
  {
    path: '',
    component: ResultsComponent
  },
  {
    path: 'edit',
    component: EventResultEditComponent
  },
  {
    path: 'edit/:id',
    component: EventResultEditComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ResultsRoutingModule { }
