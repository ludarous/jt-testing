import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

/**
 * Definition of routes.
 * If AuthGuard is used, user has to be logged in. If allowedRoles is defined, only specific roles can access it;
 * if it's not defined all roles can access.
 */
export const appRoutes: Routes = [
  {
    path: 'account',
    loadChildren: 'app/pages/account/account.module#AccountModule',
  },
];

@NgModule({
  imports: [RouterModule.forRoot(appRoutes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
