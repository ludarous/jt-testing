import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IWorkout } from 'app/shared/model/activity-group.model';

@Component({
    selector: 'jhi-activity-group-detail',
    templateUrl: './workout-detail.component.html'
})
export class WorkoutDetailComponent implements OnInit {
    workout: IWorkout;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ workout }) => {
            this.workout = workout;
        });
    }

    previousState() {
        window.history.back();
    }
}
