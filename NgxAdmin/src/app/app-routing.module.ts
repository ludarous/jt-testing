import { ExtraOptions, RouterModule, Routes } from '@angular/router';
import { NgModule } from '@angular/core';
import {HomeComponent} from './anonymous/home/home.component';
import {AnonymousComponent} from './anonymous/anonymous.component';

const routes: Routes = [
  {
    path: '',
    component: AnonymousComponent,
    children: [
      {
        path: 'home',
        component: HomeComponent
      },
      {
        path: 'about',
        component: HomeComponent
      },
      {
        path: 'pricing',
        component: HomeComponent
      },
      {
        path: 'features',
        component: HomeComponent
      }
    ]
  },
  { path: 'pages', loadChildren: 'app/pages/pages.module#PagesModule' },
  { path: 'account', loadChildren: 'app/account/account.module#AccountModule'},
  { path: 'anonymous', loadChildren: 'app/anonymous/anonymous.module#AnonymousModule'},
  { path: '', redirectTo: 'anonymous', pathMatch: 'full' },
  { path: '**', redirectTo: 'anonymous' },
];

const config: ExtraOptions = {
  useHash: true,
};

@NgModule({
  imports: [RouterModule.forRoot(routes, config)],
  exports: [RouterModule],
})
export class AppRoutingModule {
}
