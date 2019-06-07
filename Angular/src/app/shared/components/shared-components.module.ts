import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MenuComponent } from './menu/menu.component';
import {RouterModule} from '@angular/router';
import {PersonService} from '../../services/person.service';
import {MaterialComponentsModule} from '../material-components.module';
import { SidebarComponent } from './sidebar/sidebar.component';
import {PrimeNgComponentsModule} from '../primeng-components.module';
import { SidebarMenuItemComponent } from './sidebar/sidebar-menu-item/sidebar-menu-item.component';

const COMPONENTS = [
  MenuComponent,
  SidebarComponent,
  SidebarMenuItemComponent,
]

@NgModule({
  imports: [
    CommonModule,
    RouterModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
  ],
  declarations: [
    ...COMPONENTS,
  ],
  providers: [
    PersonService,
  ],
  exports: [
    ...COMPONENTS,
  ]
})
export class SharedComponentsModule { }
