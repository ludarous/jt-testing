import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MenuComponent } from './menu/menu.component';
import {RouterModule} from '@angular/router';
import {PersonService} from '../../services/person.service';
import {MaterialComponentsModule} from '../material-components.module';
import { SidebarComponent } from './sidebar/sidebar.component';
import {PrimeNgComponentsModule} from '../primeng-components.module';
import { SidebarMenuItemComponent } from './sidebar/sidebar-menu-item/sidebar-menu-item.component';
import { LrFormFieldComponent } from './lr-form-field/lr-form-field.component';
import { LrFormFieldMessageComponent } from './lr-form-field-message/lr-form-field-message.component';
import { LrInputFieldComponent } from './lr-input-field/lr-input-field.component';
import {TranslateModule} from '@ngx-translate/core';
import {ReactiveFormsModule} from '@angular/forms';

const COMPONENTS = [
  MenuComponent,
  SidebarComponent,
  SidebarMenuItemComponent,
  LrFormFieldComponent,
  LrFormFieldMessageComponent,
  LrInputFieldComponent,

]

@NgModule({
  imports: [
    CommonModule,
    RouterModule,
    ReactiveFormsModule,
    MaterialComponentsModule,
    PrimeNgComponentsModule,
    TranslateModule,
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
