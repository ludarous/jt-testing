import {NgModule} from '@angular/core';
import {EnumTranslatorPipe, EnumTranslatorService} from './enum-translator';

@NgModule({
  imports: [
  ],
  declarations: [
    EnumTranslatorPipe,
  ],
  providers: [
    EnumTranslatorService
  ],
  exports: [
    EnumTranslatorPipe,
  ]
})
export class EnumTranslationsModule {
}
