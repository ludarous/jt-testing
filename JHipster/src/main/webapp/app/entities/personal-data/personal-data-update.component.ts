import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import * as moment from 'moment';
import { DATE_TIME_FORMAT } from 'app/shared/constants/input.constants';

import { IPersonalData } from 'app/shared/model/personal-data.model';
import { PersonalDataService } from './personal-data.service';

@Component({
    selector: 'jhi-personal-data-update',
    templateUrl: './personal-data-update.component.html'
})
export class PersonalDataUpdateComponent implements OnInit {
    private _personalData: IPersonalData;
    isSaving: boolean;
    birthDate: string;

    constructor(private personalDataService: PersonalDataService, private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ personalData }) => {
            this.personalData = personalData;
        });
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        this.personalData.birthDate = moment(this.birthDate, DATE_TIME_FORMAT);
        if (this.personalData.id !== undefined) {
            this.subscribeToSaveResponse(this.personalDataService.update(this.personalData));
        } else {
            this.subscribeToSaveResponse(this.personalDataService.create(this.personalData));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IPersonalData>>) {
        result.subscribe((res: HttpResponse<IPersonalData>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
    }

    private onSaveSuccess() {
        this.isSaving = false;
        this.previousState();
    }

    private onSaveError() {
        this.isSaving = false;
    }
    get personalData() {
        return this._personalData;
    }

    set personalData(personalData: IPersonalData) {
        this._personalData = personalData;
        this.birthDate = moment(personalData.birthDate).format(DATE_TIME_FORMAT);
    }
}
