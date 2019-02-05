import {Injectable, Pipe, PipeTransform} from '@angular/core';
import {TranslateService} from '@ngx-translate/core';
import {EnumWrapper} from '../../../entities/enums/enum-wrapper';
import {ActivityResultUnits} from '../../../entities/enums/activity-result-units';
import {ResultType} from '../../../entities/enums/result-type';
import {Sex} from '../../../entities/enums/sex';

@Injectable()
export class EnumTranslatorService {

  constructor(private translateService: TranslateService) {

  }


  public translate(enumObj: EnumWrapper, args: string = null): string {

    let argsArray: Array<string>;
    if (args) {
      argsArray = args.split(',');
    }

    if (enumObj) {
      if (enumObj instanceof ActivityResultUnits) {

        if (argsArray) {
          if (argsArray.some(a => a === 'abbr')) {
            switch (enumObj.value) {
              case 'SECONDS':
                return this.translateService.instant('s');
              case 'MINUTES':
                return this.translateService.instant('m');
              case 'CENTIMETERS':
                return this.translateService.instant('cm');
              case 'METERS':
                return this.translateService.instant('m');
              case 'COUNTS':
                return this.translateService.instant('opakování');
              case 'GOALS':
                return this.translateService.instant('gólů');
              case 'POINTS':
                return this.translateService.instant('bodů');
              case 'PERCENTS':
                return this.translateService.instant('%');
            }
          }

          if (argsArray.some(a => a === 'plural')) {
            switch (enumObj.value) {
              case 'SECONDS':
                return this.translateService.instant('sekund');
              case 'MINUTES':
                return this.translateService.instant('minut');
              case 'CENTIMETERS':
                return this.translateService.instant('centimetrů');
              case 'METERS':
                return this.translateService.instant('metrů');
              case 'COUNTS':
                return this.translateService.instant('opakování');
              case 'GOALS':
                return this.translateService.instant('gólů');
              case 'POINTS':
                return this.translateService.instant('bodů');
              case 'PERCENTS':
                return this.translateService.instant('procent');
            }
          }

          if (argsArray.some(a => a === 'plural-1p')) {
            switch (enumObj.value) {
              case 'SECONDS':
                return this.translateService.instant('sekundy');
              case 'MINUTES':
                return this.translateService.instant('minuty');
              case 'CENTIMETERS':
                return this.translateService.instant('centimetry');
              case 'METERS':
                return this.translateService.instant('metry');
              case 'COUNTS':
                return this.translateService.instant('opakování');
              case 'GOALS':
                return this.translateService.instant('góly');
              case 'POINTS':
                return this.translateService.instant('body');
              case 'PERCENTS':
                return this.translateService.instant('procenta');
            }
          }
        }

        switch (enumObj.value) {
          case 'SECONDS':
            return this.translateService.instant('sekunda');
          case 'MINUTES':
            return this.translateService.instant('minuta');
          case 'CENTIMETERS':
            return this.translateService.instant('centimetr');
          case 'METERS':
            return this.translateService.instant('metr');
          case 'COUNTS':
            return this.translateService.instant('opakování');
          case 'GOALS':
            return this.translateService.instant('gól');
          case 'POINTS':
            return this.translateService.instant('bod');
          case 'PERCENTS':
            return this.translateService.instant('procento');
        }

      } else if (enumObj instanceof ResultType) {

        switch (enumObj.value) {
          case 'LESS_IS_BETTER':
            return this.translateService.instant('Méně jé lépe');
          case 'MORE_IS_BETTER':
            return this.translateService.instant('Více je lépe');
          case 'NONE':
            return this.translateService.instant('Neurčeno');
        }

      } else if (enumObj instanceof Sex) {
        switch (enumObj.value) {
          case 'MALE':
            return this.translateService.instant('Muž');
          case 'FEMALE':
            return this.translateService.instant('Žena');
          case 'OTHER':
            return this.translateService.instant('Jiné');
        }

      } else {
        return '' + (typeof enumObj) + '.' + enumObj.value;
      }
      return this.translateService.instant('není definováno');
    }
  }
}

@Pipe({name: 'enumTranslator'})
export class EnumTranslatorPipe implements PipeTransform {

  constructor(private enumTranslatorService: EnumTranslatorService) {

  }

  transform(value: EnumWrapper, args: string): string {
    return this.enumTranslatorService.translate(value, args);
  }

}
