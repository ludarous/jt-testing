import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { JtTestingSharedModule } from 'app/shared';
import {
    PersonGroupComponent,
    PersonGroupDetailComponent,
    PersonGroupUpdateComponent,
    PersonGroupDeletePopupComponent,
    PersonGroupDeleteDialogComponent,
    personGroupRoute,
    personGroupPopupRoute
} from './';

const ENTITY_STATES = [...personGroupRoute, ...personGroupPopupRoute];

@NgModule({
    imports: [JtTestingSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        PersonGroupComponent,
        PersonGroupDetailComponent,
        PersonGroupUpdateComponent,
        PersonGroupDeleteDialogComponent,
        PersonGroupDeletePopupComponent
    ],
    entryComponents: [PersonGroupComponent, PersonGroupUpdateComponent, PersonGroupDeleteDialogComponent, PersonGroupDeletePopupComponent],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class JtTestingPersonGroupModule {}
