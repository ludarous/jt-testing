import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IWorkoutResult } from 'app/shared/model/workout-result.model';

@Component({
    selector: 'jhi-workout-result-detail',
    templateUrl: './workout-result-detail.component.html'
})
export class WorkoutResultDetailComponent implements OnInit {
    workoutResult: IWorkoutResult;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ workoutResult }) => {
            this.workoutResult = workoutResult;
        });
    }

    previousState() {
        window.history.back();
    }
}
