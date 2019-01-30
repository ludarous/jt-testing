import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { JtTestingSharedModule } from 'app/shared';
import {
    EventResultComponent,
    EventResultDetailComponent,
    EventResultUpdateComponent,
    EventResultDeletePopupComponent,
    EventResultDeleteDialogComponent,
    eventResultRoute,
    eventResultPopupRoute
} from './';

const ENTITY_STATES = [...eventResultRoute, ...eventResultPopupRoute];

@NgModule({
    imports: [JtTestingSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        EventResultComponent,
        EventResultDetailComponent,
        EventResultUpdateComponent,
        EventResultDeleteDialogComponent,
        EventResultDeletePopupComponent
    ],
    entryComponents: [EventResultComponent, EventResultUpdateComponent, EventResultDeleteDialogComponent, EventResultDeletePopupComponent],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class JtTestingEventResultModule {}
