export interface ITestCategory {
    id?: number;
    name?: string;
    key?: string;
    description?: string;
}

export class TestCategory implements ITestCategory {
    constructor(public id?: number, public name?: string, public key?: string, public description?: string) {}
}
