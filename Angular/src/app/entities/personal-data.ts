import {Sex} from './enums/sex';
import {HttpResponse} from '@angular/common/http';
import {Workout} from './workout';
import {IEvent} from './event';
import {IPersonFull} from './person-full';
import {ActivityResultUnits} from './enums/activity-result-units';
import {ResultType} from './enums/result-type';

export interface IPersonalData {
  id?: any;
  firstName?: string;
  lastName?: string;
  birthDate?: string;
  nationality?: string;
  sex?: Sex;
}

export class PersonalData implements IPersonalData {
  id: any;
  firstName: string;
  lastName: string;
  birthDate: string;
  nationality: string;
  sex: Sex;


  static parseItemEnums(personalData: any): IPersonalData {
    if (personalData) {

      if (personalData.sex != null) {
        personalData.sex = new Sex(<string>personalData.sex);
      }

    }
    return personalData;
  }

  static parseItemsEnums(personalDatas: Array<any>): Array<IPersonalData> {
    if (personalDatas) {
      for (const pd of personalDatas) {
        PersonalData.parseItemEnums(pd);
      }
    }
    return personalDatas;
  }
}
