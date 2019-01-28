import { Moment } from 'moment';
import { IActivityCategory } from 'app/shared/model//activity-category.model';

export const enum ActivityResultUnits {
    SECONDS = 'SECONDS',
    MINUTES = 'MINUTES',
    CENTIMETERS = 'CENTIMETERS',
    METERS = 'METERS',
    COUNTS = 'COUNTS',
    GOALS = 'GOALS',
    POINTS = 'POINTS',
    PERCENTS = 'PERCENTS'
}

export const enum ResultType {
    LESS_IS_BETTER = 'LESS_IS_BETTER',
    MORE_IS_BETTER = 'MORE_IS_BETTER'
}

export interface IActivity {
    id?: number;
    name?: string;
    description?: string;
    help?: string;
    key?: string;
    primaryResultValueUnit?: ActivityResultUnits;
    secondaryResultValueUnit?: ActivityResultUnits;
    minAge?: number;
    maxAge?: number;
    primaryResultType?: ResultType;
    secondaryResultType?: ResultType;
    creationTime?: Moment;
    categories?: IActivityCategory[];
    authorEmail?: string;
    authorId?: number;
    groupName?: string;
    groupId?: number;
}

export class Activity implements IActivity {
    constructor(
        public id?: number,
        public name?: string,
        public description?: string,
        public help?: string,
        public key?: string,
        public primaryResultValueUnit?: ActivityResultUnits,
        public secondaryResultValueUnit?: ActivityResultUnits,
        public minAge?: number,
        public maxAge?: number,
        public primaryResultType?: ResultType,
        public secondaryResultType?: ResultType,
        public creationTime?: Moment,
        public categories?: IActivityCategory[],
        public authorEmail?: string,
        public authorId?: number,
        public groupName?: string,
        public groupId?: number
    ) {}
}
