import {NgModule} from '@angular/core';
import {Routes, RouterModule} from '@angular/router';
import {EventsComponent} from './events.component';
import {EventListComponent} from './list/event-list.component';
import {EventEditComponent} from './edit/event-edit.component';

const routes: Routes = [
  {
    path: '',
    component: EventsComponent,
    children: [
      {
        path: '',
        redirectTo: 'list'
      },
      {
        path: 'list',
        component: EventListComponent
      },
      {
        path: 'create',
        component: EventEditComponent
      },
      {
        path: 'edit/:id',
        component: EventEditComponent,
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class EventsRoutingModule {
}
