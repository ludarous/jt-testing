import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AnonymousRoutingModule } from './anonymous-routing.module';
import {AnonymousComponent} from './anonymous.component';
import { HomeComponent } from './home/home.component';
import {ThemeModule} from '../@theme/theme.module';

@NgModule({
  declarations: [
    AnonymousComponent,
    HomeComponent,
  ],
  imports: [
    CommonModule,
    // AnonymousRoutingModule,
    ThemeModule
  ],
  exports: [
    HomeComponent
  ]
})
export class AnonymousModule { }
