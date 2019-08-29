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
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {LrSelectComponent} from './lr-select/lr-select.component';
import {LrAutocompleteComponent} from './lr-autocomplete/lr-autocomplete.component';

const COMPONENTS = [
  MenuComponent,
  SidebarComponent,
  SidebarMenuItemComponent,
  LrFormFieldComponent,
  LrFormFieldMessageComponent,
  LrInputFieldComponent,
  LrSelectComponent,
  LrAutocompleteComponent
]

@NgModule({
  imports: [
    CommonModule,
    RouterModule,
    FormsModule,
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
    ...COMPONENTS
  ]
})
export class SharedComponentsModule { }
