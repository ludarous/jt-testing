import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { IWorkoutResult } from 'app/shared/model/workout-result.model';
import { WorkoutResultService } from './workout-result.service';
import { IEventResult } from 'app/shared/model/event-result.model';
import { EventResultService } from 'app/entities/event-result';
import { IWorkout } from 'app/shared/model/workout.model';
import { WorkoutService } from 'app/entities/workout';

@Component({
    selector: 'jhi-workout-result-update',
    templateUrl: './workout-result-update.component.html'
})
export class WorkoutResultUpdateComponent implements OnInit {
    private _workoutResult: IWorkoutResult;
    isSaving: boolean;

    eventresults: IEventResult[];

    workouts: IWorkout[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private workoutResultService: WorkoutResultService,
        private eventResultService: EventResultService,
        private workoutService: WorkoutService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ workoutResult }) => {
            this.workoutResult = workoutResult;
        });
        this.eventResultService.query().subscribe(
            (res: HttpResponse<IEventResult[]>) => {
                this.eventresults = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.workoutService.query().subscribe(
            (res: HttpResponse<IWorkout[]>) => {
                this.workouts = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.workoutResult.id !== undefined) {
            this.subscribeToSaveResponse(this.workoutResultService.update(this.workoutResult));
        } else {
            this.subscribeToSaveResponse(this.workoutResultService.create(this.workoutResult));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IWorkoutResult>>) {
        result.subscribe((res: HttpResponse<IWorkoutResult>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
    }

    private onSaveSuccess() {
        this.isSaving = false;
        this.previousState();
    }

    private onSaveError() {
        this.isSaving = false;
    }

    private onError(errorMessage: string) {
        this.jhiAlertService.error(errorMessage, null, null);
    }

    trackEventResultById(index: number, item: IEventResult) {
        return item.id;
    }

    trackWorkoutById(index: number, item: IWorkout) {
        return item.id;
    }
    get workoutResult() {
        return this._workoutResult;
    }

    set workoutResult(workoutResult: IWorkoutResult) {
        this._workoutResult = workoutResult;
    }
}
