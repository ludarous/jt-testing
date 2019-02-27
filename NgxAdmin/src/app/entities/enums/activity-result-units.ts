import {EnumWrapper} from './enum-wrapper';
import {AuthoritiesEnum} from './authorities';

export enum ActivityResultUnitsEnum {
  SECONDS, MINUTES, CENTIMETERS, METERS, COUNTS, GOALS, POINTS, PERCENTS
}

export class ActivityResultUnits extends EnumWrapper {

  constructor(value: number | string) {
    super(ActivityResultUnitsEnum, value);
  }

  public static SECONDS = new ActivityResultUnits(ActivityResultUnitsEnum.SECONDS);
  public static MINUTES = new ActivityResultUnits(ActivityResultUnitsEnum.MINUTES);
  public static CENTIMETERS = new ActivityResultUnits(ActivityResultUnitsEnum.CENTIMETERS);
  public static METERS = new ActivityResultUnits(ActivityResultUnitsEnum.METERS);
  public static COUNTS = new ActivityResultUnits(ActivityResultUnitsEnum.COUNTS);
  public static GOALS = new ActivityResultUnits(ActivityResultUnitsEnum.GOALS);
  public static POINTS = new ActivityResultUnits(ActivityResultUnitsEnum.POINTS);
  public static PERCENTS = new ActivityResultUnits(ActivityResultUnitsEnum.PERCENTS);

  private static all: Array<ActivityResultUnits> = new Array<ActivityResultUnits>(
    ActivityResultUnits.SECONDS,
    ActivityResultUnits.MINUTES,
    ActivityResultUnits.CENTIMETERS,
    ActivityResultUnits.METERS,
    ActivityResultUnits.COUNTS,
    ActivityResultUnits.GOALS,
    ActivityResultUnits.POINTS,
    ActivityResultUnits.PERCENTS
  );

  public static getAll(): Array<ActivityResultUnits> {
    return ActivityResultUnits.all;
  }
}
