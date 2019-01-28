import { IGroup } from 'app/shared/model//group.model';

export interface IGroup {
    id?: number;
    name?: string;
    parentName?: string;
    parentId?: number;
    children?: IGroup[];
}

export class Group implements IGroup {
    constructor(
        public id?: number,
        public name?: string,
        public parentName?: string,
        public parentId?: number,
        public children?: IGroup[]
    ) {}
}
