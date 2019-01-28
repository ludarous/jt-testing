export interface IActivityGroupCategory {
    id?: number;
    name?: string;
    key?: string;
    description?: string;
}

export class ActivityGroupCategory implements IActivityGroupCategory {
    constructor(public id?: number, public name?: string, public key?: string, public description?: string) {}
}
