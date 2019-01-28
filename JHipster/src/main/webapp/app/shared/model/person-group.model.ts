export const enum GroupAuthority {
    ADMIN = 'ADMIN',
    MEMBER = 'MEMBER'
}

export interface IPersonGroup {
    id?: number;
    groupRole?: GroupAuthority;
    personEmail?: string;
    personId?: number;
    groupName?: string;
    groupId?: number;
}

export class PersonGroup implements IPersonGroup {
    constructor(
        public id?: number,
        public groupRole?: GroupAuthority,
        public personEmail?: string,
        public personId?: number,
        public groupName?: string,
        public groupId?: number
    ) {}
}
