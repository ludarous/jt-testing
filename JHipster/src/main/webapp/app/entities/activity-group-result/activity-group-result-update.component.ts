import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { IActivityGroupResult } from 'app/shared/model/activity-group-result.model';
import { ActivityGroupResultService } from './activity-group-result.service';
import { IEventResult } from 'app/shared/model/event-result.model';
import { EventResultService } from 'app/entities/event-result';
import { IActivityGroup } from 'app/shared/model/activity-group.model';
import { ActivityGroupService } from 'app/entities/activity-group';

@Component({
    selector: 'jhi-activity-group-result-update',
    templateUrl: './activity-group-result-update.component.html'
})
export class ActivityGroupResultUpdateComponent implements OnInit {
    private _activityGroupResult: IActivityGroupResult;
    isSaving: boolean;

    eventresults: IEventResult[];

    activitygroups: IActivityGroup[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private activityGroupResultService: ActivityGroupResultService,
        private eventResultService: EventResultService,
        private activityGroupService: ActivityGroupService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ activityGroupResult }) => {
            this.activityGroupResult = activityGroupResult;
        });
        this.eventResultService.query().subscribe(
            (res: HttpResponse<IEventResult[]>) => {
                this.eventresults = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.activityGroupService.query().subscribe(
            (res: HttpResponse<IActivityGroup[]>) => {
                this.activitygroups = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.activityGroupResult.id !== undefined) {
            this.subscribeToSaveResponse(this.activityGroupResultService.update(this.activityGroupResult));
        } else {
            this.subscribeToSaveResponse(this.activityGroupResultService.create(this.activityGroupResult));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IActivityGroupResult>>) {
        result.subscribe((res: HttpResponse<IActivityGroupResult>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackActivityGroupById(index: number, item: IActivityGroup) {
        return item.id;
    }
    get activityGroupResult() {
        return this._activityGroupResult;
    }

    set activityGroupResult(activityGroupResult: IActivityGroupResult) {
        this._activityGroupResult = activityGroupResult;
    }
}
