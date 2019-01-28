import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { JtTestingSharedModule } from 'app/shared';
import {
    ActivityGroupCategoryComponent,
    ActivityGroupCategoryDetailComponent,
    ActivityGroupCategoryUpdateComponent,
    ActivityGroupCategoryDeletePopupComponent,
    ActivityGroupCategoryDeleteDialogComponent,
    activityGroupCategoryRoute,
    activityGroupCategoryPopupRoute
} from './';

const ENTITY_STATES = [...activityGroupCategoryRoute, ...activityGroupCategoryPopupRoute];

@NgModule({
    imports: [JtTestingSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        ActivityGroupCategoryComponent,
        ActivityGroupCategoryDetailComponent,
        ActivityGroupCategoryUpdateComponent,
        ActivityGroupCategoryDeleteDialogComponent,
        ActivityGroupCategoryDeletePopupComponent
    ],
    entryComponents: [
        ActivityGroupCategoryComponent,
        ActivityGroupCategoryUpdateComponent,
        ActivityGroupCategoryDeleteDialogComponent,
        ActivityGroupCategoryDeletePopupComponent
    ],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class JtTestingActivityGroupCategoryModule {}
