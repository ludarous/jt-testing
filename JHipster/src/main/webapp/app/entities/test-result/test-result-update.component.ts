import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { ITestResult } from 'app/shared/model/test-result.model';
import { TestResultService } from './test-result.service';
import { IEventResult } from 'app/shared/model/event-result.model';
import { EventResultService } from 'app/entities/event-result';
import { IJTTest } from 'app/shared/model/jt-test.model';
import { JTTestService } from 'app/entities/jt-test';

@Component({
    selector: 'jhi-test-result-update',
    templateUrl: './test-result-update.component.html'
})
export class TestResultUpdateComponent implements OnInit {
    private _testResult: ITestResult;
    isSaving: boolean;

    eventresults: IEventResult[];

    jttests: IJTTest[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private testResultService: TestResultService,
        private eventResultService: EventResultService,
        private jTTestService: JTTestService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ testResult }) => {
            this.testResult = testResult;
        });
        this.eventResultService.query().subscribe(
            (res: HttpResponse<IEventResult[]>) => {
                this.eventresults = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.jTTestService.query().subscribe(
            (res: HttpResponse<IJTTest[]>) => {
                this.jttests = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.testResult.id !== undefined) {
            this.subscribeToSaveResponse(this.testResultService.update(this.testResult));
        } else {
            this.subscribeToSaveResponse(this.testResultService.create(this.testResult));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<ITestResult>>) {
        result.subscribe((res: HttpResponse<ITestResult>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackJTTestById(index: number, item: IJTTest) {
        return item.id;
    }
    get testResult() {
        return this._testResult;
    }

    set testResult(testResult: ITestResult) {
        this._testResult = testResult;
    }
}
