import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { JtTestingSharedModule } from 'app/shared';
import {
    ActivityGroupResultComponent,
    ActivityGroupResultDetailComponent,
    ActivityGroupResultUpdateComponent,
    ActivityGroupResultDeletePopupComponent,
    ActivityGroupResultDeleteDialogComponent,
    activityGroupResultRoute,
    activityGroupResultPopupRoute
} from './';

const ENTITY_STATES = [...activityGroupResultRoute, ...activityGroupResultPopupRoute];

@NgModule({
    imports: [JtTestingSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        ActivityGroupResultComponent,
        ActivityGroupResultDetailComponent,
        ActivityGroupResultUpdateComponent,
        ActivityGroupResultDeleteDialogComponent,
        ActivityGroupResultDeletePopupComponent
    ],
    entryComponents: [
        ActivityGroupResultComponent,
        ActivityGroupResultUpdateComponent,
        ActivityGroupResultDeleteDialogComponent,
        ActivityGroupResultDeletePopupComponent
    ],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class JtTestingActivityGroupResultModule {}
