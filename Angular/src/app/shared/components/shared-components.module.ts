import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MenuComponent } from './menu/menu.component';
import {RouterModule} from '@angular/router';
import {PersonService} from '../../services/person.service';
import {MaterialComponentsModule} from '../material-components.module';

@NgModule({
  imports: [
    CommonModule,
    RouterModule,
    MaterialComponentsModule
  ],
  declarations: [
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
