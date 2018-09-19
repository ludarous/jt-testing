import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { ITestCategory } from 'app/shared/model/test-category.model';
import { TestCategoryService } from './test-category.service';

@Component({
    selector: 'jhi-test-category-update',
    templateUrl: './test-category-update.component.html'
})
export class TestCategoryUpdateComponent implements OnInit {
    private _testCategory: ITestCategory;
    isSaving: boolean;

    constructor(private testCategoryService: TestCategoryService, private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ testCategory }) => {
            this.testCategory = testCategory;
        });
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.testCategory.id !== undefined) {
            this.subscribeToSaveResponse(this.testCategoryService.update(this.testCategory));
        } else {
            this.subscribeToSaveResponse(this.testCategoryService.create(this.testCategory));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<ITestCategory>>) {
        result.subscribe((res: HttpResponse<ITestCategory>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
    }

    private onSaveSuccess() {
        this.isSaving = false;
        this.previousState();
    }

    private onSaveError() {
        this.isSaving = false;
    }
    get testCategory() {
        return this._testCategory;
    }

    set testCategory(testCategory: ITestCategory) {
        this._testCategory = testCategory;
    }
}
