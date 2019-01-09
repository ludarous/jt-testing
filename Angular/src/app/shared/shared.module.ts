import { NgModule } from '@angular/core';
import {TranslateService} from '@ngx-translate/core';
import {KeysPipe} from './pipes/keys.pipe';
import {DatexPipe} from './pipes/datex/datex.pipe';

@NgModule({
  declarations: [
    KeysPipe,
    DatexPipe
  ],
  imports: [

  ],
  providers: [
    TranslateService,
  ],
  exports: [
    KeysPipe,
    DatexPipe
  ]
})
export class SharedModule { }
