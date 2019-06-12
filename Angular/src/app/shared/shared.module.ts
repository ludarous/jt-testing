import { NgModule } from '@angular/core';
import {TranslateService} from '@ngx-translate/core';
import {KeysPipe} from './pipes/keys.pipe';
import {DatexPipe} from './pipes/datex/datex.pipe';
import {LrInputDirective} from './directives/lr-input.directive';

@NgModule({
  declarations: [
    KeysPipe,
    DatexPipe,

    LrInputDirective,
  ],
  imports: [

  ],
  providers: [
    TranslateService,
  ],
  exports: [
    KeysPipe,
    DatexPipe,

    LrInputDirective,
  ]
})
export class SharedModule { }
