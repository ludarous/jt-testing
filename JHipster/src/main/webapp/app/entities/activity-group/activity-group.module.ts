import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { JtTestingSharedModule } from 'app/shared';
import {
    ActivityGroupComponent,
    ActivityGroupDetailComponent,
    ActivityGroupUpdateComponent,
    ActivityGroupDeletePopupComponent,
    ActivityGroupDeleteDialogComponent,
    activityGroupRoute,
    activityGroupPopupRoute
} from './';

const ENTITY_STATES = [...activityGroupRoute, ...activityGroupPopupRoute];

@NgModule({
    imports: [JtTestingSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        ActivityGroupComponent,
        ActivityGroupDetailComponent,
        ActivityGroupUpdateComponent,
        ActivityGroupDeleteDialogComponent,
        ActivityGroupDeletePopupComponent
    ],
    entryComponents: [
        ActivityGroupComponent,
        ActivityGroupUpdateComponent,
        ActivityGroupDeleteDialogComponent,
        ActivityGroupDeletePopupComponent
    ],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class JtTestingActivityGroupModule {}
