import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { RouterModule } from '@angular/router';

import { JtTestingSharedModule } from 'app/shared';
import {
    WorkoutCategoryComponent,
    WorkoutCategoryDetailComponent,
    WorkoutCategoryUpdateComponent,
    WorkoutCategoryDeletePopupComponent,
    WorkoutCategoryDeleteDialogComponent,
    workoutCategoryRoute,
    workoutCategoryPopupRoute
} from './';

const ENTITY_STATES = [...workoutCategoryRoute, ...workoutCategoryPopupRoute];

@NgModule({
    imports: [JtTestingSharedModule, RouterModule.forChild(ENTITY_STATES)],
    declarations: [
        WorkoutCategoryComponent,
        WorkoutCategoryDetailComponent,
        WorkoutCategoryUpdateComponent,
        WorkoutCategoryDeleteDialogComponent,
        WorkoutCategoryDeletePopupComponent
    ],
    entryComponents: [
        WorkoutCategoryComponent,
        WorkoutCategoryUpdateComponent,
        WorkoutCategoryDeleteDialogComponent,
        WorkoutCategoryDeletePopupComponent
    ],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class JtTestingWorkoutCategoryModule {}