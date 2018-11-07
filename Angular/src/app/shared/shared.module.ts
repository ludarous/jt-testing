import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {TranslateDirective, TranslatePipe, TranslateService} from '@ngx-translate/core';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {MenuComponent} from './components/menu/menu.component';

@NgModule({
  declarations: [

  ],
  imports: [

  ],
  providers: [
    TranslateService,
  ],
  exports: [

  ]
})
export class SharedModule { }
