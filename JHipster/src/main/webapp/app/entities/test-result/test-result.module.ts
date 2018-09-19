import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { JtTestingSharedModule } from 'app/shared';
import {
    TestResultComponent,
    TestResultDetailComponent,
    TestResultUpdateComponent,
    TestResultDeletePopupComponent,
    TestResultDeleteDialogComponent,
    testResultRoute,
    testResultPopupRoute
} from './';

const ENTITY_STATES = [...testResultRoute, ...testResultPopupRoute];

@NgModule({
    imports: [JtTestingSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        TestResultComponent,
        TestResultDetailComponent,
        TestResultUpdateComponent,
        TestResultDeleteDialogComponent,
        TestResultDeletePopupComponent
    ],
    entryComponents: [TestResultComponent, TestResultUpdateComponent, TestResultDeleteDialogComponent, TestResultDeletePopupComponent],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class JtTestingTestResultModule {}
