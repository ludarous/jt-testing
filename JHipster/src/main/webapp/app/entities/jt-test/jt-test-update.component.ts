import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { IJTTest } from 'app/shared/model/jt-test.model';
import { JTTestService } from './jt-test.service';
import { IActivity } from 'app/shared/model/activity.model';
import { ActivityService } from 'app/entities/activity';
import { ITestCategory } from 'app/shared/model/test-category.model';
import { TestCategoryService } from 'app/entities/test-category';
import { ISport } from 'app/shared/model/sport.model';
import { SportService } from 'app/entities/sport';

@Component({
    selector: 'jhi-jt-test-update',
    templateUrl: './jt-test-update.component.html'
})
export class JTTestUpdateComponent implements OnInit {
    private _jTTest: IJTTest;
    isSaving: boolean;

    activities: IActivity[];

    testcategories: ITestCategory[];

    sports: ISport[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private jTTestService: JTTestService,
        private activityService: ActivityService,
        private testCategoryService: TestCategoryService,
        private sportService: SportService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ jTTest }) => {
            this.jTTest = jTTest;
        });
        this.activityService.query().subscribe(
            (res: HttpResponse<IActivity[]>) => {
                this.activities = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.testCategoryService.query().subscribe(
            (res: HttpResponse<ITestCategory[]>) => {
                this.testcategories = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.sportService.query().subscribe(
            (res: HttpResponse<ISport[]>) => {
                this.sports = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.jTTest.id !== undefined) {
            this.subscribeToSaveResponse(this.jTTestService.update(this.jTTest));
        } else {
            this.subscribeToSaveResponse(this.jTTestService.create(this.jTTest));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IJTTest>>) {
        result.subscribe((res: HttpResponse<IJTTest>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackActivityById(index: number, item: IActivity) {
        return item.id;
    }

    trackTestCategoryById(index: number, item: ITestCategory) {
        return item.id;
    }

    trackSportById(index: number, item: ISport) {
        return item.id;
    }

    getSelected(selectedVals: Array<any>, option: any) {
        if (selectedVals) {
            for (let i = 0; i < selectedVals.length; i++) {
                if (option.id === selectedVals[i].id) {
                    return selectedVals[i];
                }
            }
        }
        return option;
    }
    get jTTest() {
        return this._jTTest;
    }

    set jTTest(jTTest: IJTTest) {
        this._jTTest = jTTest;
    }
}
