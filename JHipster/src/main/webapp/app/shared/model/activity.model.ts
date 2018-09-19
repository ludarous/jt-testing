import { IActivityCategory } from 'app/shared/model//activity-category.model';

export const enum ActivityResultUnits {
    SECONDS = 'SECONDS',
    MINUTES = 'MINUTES',
    CENTIMETERS = 'CENTIMETERS',
    METERS = 'METERS',
    COUNTS = 'COUNTS',
    GOALS = 'GOALS',
    POINTS = 'POINTS',
    PERECENTS = 'PERECENTS'
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
    categories?: IActivityCategory[];
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
        public categories?: IActivityCategory[]
    ) {}
}
