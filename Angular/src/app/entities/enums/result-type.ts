import {EnumWrapper} from './enum-wrapper';

export enum ResultTypeEnum {
  LESS_IS_BETTER, MORE_IS_BETTER
}

export class ResultType extends EnumWrapper {

  constructor(value: number | string) {
    super(ResultTypeEnum, value);
  }

  public static LESS_IS_BETTER = new ResultType(ResultTypeEnum.LESS_IS_BETTER);
  public static MORE_IS_BETTER = new ResultType(ResultTypeEnum.MORE_IS_BETTER);


  private static all: Array<ResultType> = new Array<ResultType>(
    ResultType.LESS_IS_BETTER,
    ResultType.MORE_IS_BETTER,

  );

  public static getAll(): Array<ResultType> {
    return ResultType.all;
  }
}
