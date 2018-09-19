import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';

import { JtTestingEventModule } from './event/event.module';
import { JtTestingJTTestModule } from './jt-test/jt-test.module';
import { JtTestingActivityModule } from './activity/activity.module';
import { JtTestingTestCategoryModule } from './test-category/test-category.module';
import { JtTestingActivityCategoryModule } from './activity-category/activity-category.module';
import { JtTestingEventResultModule } from './event-result/event-result.module';
import { JtTestingTestResultModule } from './test-result/test-result.module';
import { JtTestingActivityResultModule } from './activity-result/activity-result.module';
import { JtTestingPersonModule } from './person/person.module';
import { JtTestingPersonalDataModule } from './personal-data/personal-data.module';
import { JtTestingAddressModule } from './address/address.module';
import { JtTestingSportModule } from './sport/sport.module';
/* jhipster-needle-add-entity-module-import - JHipster will add entity modules imports here */

@NgModule({
    // prettier-ignore
    imports: [
        JtTestingEventModule,
        JtTestingJTTestModule,
        JtTestingActivityModule,
        JtTestingTestCategoryModule,
        JtTestingActivityCategoryModule,
        JtTestingEventResultModule,
        JtTestingTestResultModule,
        JtTestingActivityResultModule,
        JtTestingPersonModule,
        JtTestingPersonalDataModule,
        JtTestingAddressModule,
        JtTestingSportModule,
        /* jhipster-needle-add-entity-module - JHipster will add entity modules here */
    ],
    declarations: [],
    entryComponents: [],
    providers: [],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class JtTestingEntityModule {}
