import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { JtTestingSharedModule } from 'app/shared';
import {
    TestCategoryComponent,
    TestCategoryDetailComponent,
    TestCategoryUpdateComponent,
    TestCategoryDeletePopupComponent,
    TestCategoryDeleteDialogComponent,
    testCategoryRoute,
    testCategoryPopupRoute
} from './';

const ENTITY_STATES = [...testCategoryRoute, ...testCategoryPopupRoute];

@NgModule({
    imports: [JtTestingSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        TestCategoryComponent,
        TestCategoryDetailComponent,
        TestCategoryUpdateComponent,
        TestCategoryDeleteDialogComponent,
        TestCategoryDeletePopupComponent
    ],
    entryComponents: [
        TestCategoryComponent,
        TestCategoryUpdateComponent,
        TestCategoryDeleteDialogComponent,
        TestCategoryDeletePopupComponent
    ],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class JtTestingTestCategoryModule {}
