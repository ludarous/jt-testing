import { IActivity } from 'app/shared/model//activity.model';
import { IActivityGroupCategory } from 'app/shared/model//activity-group-category.model';

export interface IActivityGroup {
    id?: number;
    name?: string;
    description?: string;
    minAge?: number;
    maxAge?: number;
    activities?: IActivity[];
    activityGroupCategories?: IActivityGroupCategory[];
}

export class ActivityGroup implements IActivityGroup {
    constructor(
        public id?: number,
        public name?: string,
        public description?: string,
        public minAge?: number,
        public maxAge?: number,
        public activities?: IActivity[],
        public activityGroupCategories?: IActivityGroupCategory[]
    ) {}
}
