import { IActivity } from 'app/shared/model//activity.model';
import { ITestCategory } from 'app/shared/model//test-category.model';
import { ISport } from 'app/shared/model//sport.model';

export interface IJTTest {
    id?: number;
    name?: string;
    description?: string;
    activities?: IActivity[];
    categories?: ITestCategory[];
    sports?: ISport[];
}

export class JTTest implements IJTTest {
    constructor(
        public id?: number,
        public name?: string,
        public description?: string,
        public activities?: IActivity[],
        public categories?: ITestCategory[],
        public sports?: ISport[]
    ) {}
}
