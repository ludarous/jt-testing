import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProfileComponent } from './profile/profile.component';
import { MenuComponent } from './menu/menu.component';
import {RouterModule} from '@angular/router';
import {PersonService} from '../../services/person.service';

@NgModule({
  imports: [
    CommonModule,
    RouterModule
  ],
  declarations: [
    ProfileComponent,
    MenuComponent
  ],
  providers: [
    PersonService,
  ],
  exports: [
    MenuComponent
  ]
})
export class SharedComponentsModule { }
