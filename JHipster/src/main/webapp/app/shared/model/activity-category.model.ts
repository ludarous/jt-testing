export interface IActivityCategory {
    id?: number;
    name?: string;
    key?: string;
    description?: string;
}

export class ActivityCategory implements IActivityCategory {
    constructor(public id?: number, public name?: string, public key?: string, public description?: string) {}
}
