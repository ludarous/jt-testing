import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { IActivityResult } from 'app/shared/model/activity-result.model';
import { ActivityResultService } from './activity-result.service';
import { ITestResult } from 'app/shared/model/test-result.model';
import { TestResultService } from 'app/entities/test-result';
import { IActivity } from 'app/shared/model/activity.model';
import { ActivityService } from 'app/entities/activity';

@Component({
    selector: 'jhi-activity-result-update',
    templateUrl: './activity-result-update.component.html'
})
export class ActivityResultUpdateComponent implements OnInit {
    private _activityResult: IActivityResult;
    isSaving: boolean;

    testresults: ITestResult[];

    activities: IActivity[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private activityResultService: ActivityResultService,
        private testResultService: TestResultService,
        private activityService: ActivityService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ activityResult }) => {
            this.activityResult = activityResult;
        });
        this.testResultService.query().subscribe(
            (res: HttpResponse<ITestResult[]>) => {
                this.testresults = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.activityService.query().subscribe(
            (res: HttpResponse<IActivity[]>) => {
                this.activities = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.activityResult.id !== undefined) {
            this.subscribeToSaveResponse(this.activityResultService.update(this.activityResult));
        } else {
            this.subscribeToSaveResponse(this.activityResultService.create(this.activityResult));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IActivityResult>>) {
        result.subscribe((res: HttpResponse<IActivityResult>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackTestResultById(index: number, item: ITestResult) {
        return item.id;
    }

    trackActivityById(index: number, item: IActivity) {
        return item.id;
    }
    get activityResult() {
        return this._activityResult;
    }

    set activityResult(activityResult: IActivityResult) {
        this._activityResult = activityResult;
    }
}
