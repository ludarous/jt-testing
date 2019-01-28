import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { IActivityGroup } from 'app/shared/model/activity-group.model';
import { ActivityGroupService } from './activity-group.service';
import { IActivity } from 'app/shared/model/activity.model';
import { ActivityService } from 'app/entities/activity';
import { IActivityGroupCategory } from 'app/shared/model/activity-group-category.model';
import { ActivityGroupCategoryService } from 'app/entities/activity-group-category';

@Component({
    selector: 'jhi-activity-group-update',
    templateUrl: './activity-group-update.component.html'
})
export class ActivityGroupUpdateComponent implements OnInit {
    private _activityGroup: IActivityGroup;
    isSaving: boolean;

    activities: IActivity[];

    activitygroupcategories: IActivityGroupCategory[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private activityGroupService: ActivityGroupService,
        private activityService: ActivityService,
        private activityGroupCategoryService: ActivityGroupCategoryService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ activityGroup }) => {
            this.activityGroup = activityGroup;
        });
        this.activityService.query().subscribe(
            (res: HttpResponse<IActivity[]>) => {
                this.activities = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.activityGroupCategoryService.query().subscribe(
            (res: HttpResponse<IActivityGroupCategory[]>) => {
                this.activitygroupcategories = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.activityGroup.id !== undefined) {
            this.subscribeToSaveResponse(this.activityGroupService.update(this.activityGroup));
        } else {
            this.subscribeToSaveResponse(this.activityGroupService.create(this.activityGroup));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IActivityGroup>>) {
        result.subscribe((res: HttpResponse<IActivityGroup>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackActivityGroupCategoryById(index: number, item: IActivityGroupCategory) {
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
    get activityGroup() {
        return this._activityGroup;
    }

    set activityGroup(activityGroup: IActivityGroup) {
        this._activityGroup = activityGroup;
    }
}
