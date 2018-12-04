import { IActivityCategory } from 'app/shared/model//activity-category.model';

export interface IActivityCategory {
    id?: number;
    name?: string;
    key?: string;
    description?: string;
    parentName?: string;
    parentId?: number;
    children?: IActivityCategory[];
}

export class ActivityCategory implements IActivityCategory {
    constructor(
        public id?: number,
        public name?: string,
        public key?: string,
        public description?: string,
        public parentName?: string,
        public parentId?: number,
        public children?: IActivityCategory[]
    ) {}
}
