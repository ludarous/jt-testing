import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProfileComponent } from './profile/profile.component';
import { MenuComponent } from './menu/menu.component';
import {RouterModule} from '@angular/router';

@NgModule({
  imports: [
    CommonModule,
    RouterModule
  ],
  declarations: [
    ProfileComponent,
    MenuComponent
  ],
  exports: [
    MenuComponent
  ]
})
export class SharedComponentsModule { }
