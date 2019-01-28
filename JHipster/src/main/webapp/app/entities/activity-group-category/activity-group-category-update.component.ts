import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { IActivityGroupCategory } from 'app/shared/model/activity-group-category.model';
import { ActivityGroupCategoryService } from './activity-group-category.service';

@Component({
    selector: 'jhi-activity-group-category-update',
    templateUrl: './activity-group-category-update.component.html'
})
export class ActivityGroupCategoryUpdateComponent implements OnInit {
    private _activityGroupCategory: IActivityGroupCategory;
    isSaving: boolean;

    constructor(private activityGroupCategoryService: ActivityGroupCategoryService, private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ activityGroupCategory }) => {
            this.activityGroupCategory = activityGroupCategory;
        });
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.activityGroupCategory.id !== undefined) {
            this.subscribeToSaveResponse(this.activityGroupCategoryService.update(this.activityGroupCategory));
        } else {
            this.subscribeToSaveResponse(this.activityGroupCategoryService.create(this.activityGroupCategory));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IActivityGroupCategory>>) {
        result.subscribe(
            (res: HttpResponse<IActivityGroupCategory>) => this.onSaveSuccess(),
            (res: HttpErrorResponse) => this.onSaveError()
        );
    }

    private onSaveSuccess() {
        this.isSaving = false;
        this.previousState();
    }

    private onSaveError() {
        this.isSaving = false;
    }
    get activityGroupCategory() {
        return this._activityGroupCategory;
    }

    set activityGroupCategory(activityGroupCategory: IActivityGroupCategory) {
        this._activityGroupCategory = activityGroupCategory;
    }
}
