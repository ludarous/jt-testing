import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { JtTestingSharedModule } from 'app/shared';
import {
    WorkoutResultComponent,
    WorkoutResultDetailComponent,
    WorkoutResultUpdateComponent,
    WorkoutResultDeletePopupComponent,
    WorkoutResultDeleteDialogComponent,
    workoutResultRoute,
    workoutResultPopupRoute
} from './';

const ENTITY_STATES = [...workoutResultRoute, ...workoutResultPopupRoute];

@NgModule({
    imports: [JtTestingSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        WorkoutResultComponent,
        WorkoutResultDetailComponent,
        WorkoutResultUpdateComponent,
        WorkoutResultDeleteDialogComponent,
        WorkoutResultDeletePopupComponent
    ],
    entryComponents: [
        WorkoutResultComponent,
        WorkoutResultUpdateComponent,
        WorkoutResultDeleteDialogComponent,
        WorkoutResultDeletePopupComponent
    ],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class JtTestingWorkoutResultModule {}
