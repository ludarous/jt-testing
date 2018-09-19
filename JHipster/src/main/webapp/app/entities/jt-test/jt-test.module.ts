import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { JtTestingSharedModule } from 'app/shared';
import {
    JTTestComponent,
    JTTestDetailComponent,
    JTTestUpdateComponent,
    JTTestDeletePopupComponent,
    JTTestDeleteDialogComponent,
    jTTestRoute,
    jTTestPopupRoute
} from './';

const ENTITY_STATES = [...jTTestRoute, ...jTTestPopupRoute];

@NgModule({
    imports: [JtTestingSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [JTTestComponent, JTTestDetailComponent, JTTestUpdateComponent, JTTestDeleteDialogComponent, JTTestDeletePopupComponent],
    entryComponents: [JTTestComponent, JTTestUpdateComponent, JTTestDeleteDialogComponent, JTTestDeletePopupComponent],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class JtTestingJTTestModule {}
