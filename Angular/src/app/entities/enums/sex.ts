import {EnumWrapper} from './enum-wrapper';

export enum SexEnum {
  MALE, FEMALE, OTHER
}

export class Sex extends EnumWrapper {

  constructor(value: number | string) {
    super(SexEnum, value);
  }

  public static MALE = new Sex(SexEnum.MALE);
  public static FEMALE = new Sex(SexEnum.FEMALE);
  public static OTHER = new Sex(SexEnum.OTHER);

  private static all: Array<Sex> = new Array<Sex>(
    Sex.MALE,
    Sex.FEMALE,
    Sex.OTHER,
  );

  public static getAll(): Array<Sex> {
    return Sex.all;
  }
}
