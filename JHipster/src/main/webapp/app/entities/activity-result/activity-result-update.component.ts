import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import * as moment from 'moment';
import { DATE_TIME_FORMAT } from 'app/shared/constants/input.constants';
import { JhiAlertService } from 'ng-jhipster';

import { IActivityResult } from 'app/shared/model/activity-result.model';
import { ActivityResultService } from './activity-result.service';
import { IActivityGroupResult } from 'app/shared/model/activity-group-result.model';
import { ActivityGroupResultService } from 'app/entities/activity-group-result';
import { IActivity } from 'app/shared/model/activity.model';
import { ActivityService } from 'app/entities/activity';
import { IActivityGroup } from 'app/shared/model/activity-group.model';
import { ActivityGroupService } from 'app/entities/activity-group';
import { IEvent } from 'app/shared/model/event.model';
import { EventService } from 'app/entities/event';
import { IPerson } from 'app/shared/model/person.model';
import { PersonService } from 'app/entities/person';

@Component({
    selector: 'jhi-activity-result-update',
    templateUrl: './activity-result-update.component.html'
})
export class ActivityResultUpdateComponent implements OnInit {
    private _activityResult: IActivityResult;
    isSaving: boolean;

    activitygroupresults: IActivityGroupResult[];

    activities: IActivity[];

    activitygroups: IActivityGroup[];

    events: IEvent[];

    people: IPerson[];
    date: string;

    constructor(
        private jhiAlertService: JhiAlertService,
        private activityResultService: ActivityResultService,
        private activityGroupResultService: ActivityGroupResultService,
        private activityService: ActivityService,
        private activityGroupService: ActivityGroupService,
        private eventService: EventService,
        private personService: PersonService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ activityResult }) => {
            this.activityResult = activityResult;
        });
        this.activityGroupResultService.query().subscribe(
            (res: HttpResponse<IActivityGroupResult[]>) => {
                this.activitygroupresults = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.activityService.query().subscribe(
            (res: HttpResponse<IActivity[]>) => {
                this.activities = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.activityGroupService.query().subscribe(
            (res: HttpResponse<IActivityGroup[]>) => {
                this.activitygroups = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.eventService.query().subscribe(
            (res: HttpResponse<IEvent[]>) => {
                this.events = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.personService.query().subscribe(
            (res: HttpResponse<IPerson[]>) => {
                this.people = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        this.activityResult.date = moment(this.date, DATE_TIME_FORMAT);
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

    trackActivityGroupResultById(index: number, item: IActivityGroupResult) {
        return item.id;
    }

    trackActivityById(index: number, item: IActivity) {
        return item.id;
    }

    trackActivityGroupById(index: number, item: IActivityGroup) {
        return item.id;
    }

    trackEventById(index: number, item: IEvent) {
        return item.id;
    }

    trackPersonById(index: number, item: IPerson) {
        return item.id;
    }
    get activityResult() {
        return this._activityResult;
    }

    set activityResult(activityResult: IActivityResult) {
        this._activityResult = activityResult;
        this.date = moment(activityResult.date).format(DATE_TIME_FORMAT);
    }
}
