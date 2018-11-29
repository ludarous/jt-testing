import {EnumTranslatorService} from '../shared/pipes/enum-translator/enum-translator';

export class StringUtils {

  static sortByStrings(s1: string, s2: string, order: number = 1): number {
    let val = 0;
    if (s1 < s2) val = -1;
    else if (s1 > s2) val = 1;
    return val * order;
  }

  static sortBy2Strings(object1string1: string, object1string2: string, object2string1: string, object2string2: string,
                          order: number = 1): number {
    let val = 0;
    // compare by first string of each objects
    if (object1string1 < object2string1) val = -1;
    else if (object1string1 > object2string1) val = 1;
    else {
      // compare by second string of each objects
      if (object1string2 < object2string2) val = -1;
      else if (object1string2 > object2string2) val = 1;
    }
    return val * order;
  }

}
