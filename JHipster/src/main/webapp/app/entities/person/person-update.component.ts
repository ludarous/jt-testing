import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { IPerson } from 'app/shared/model/person.model';
import { PersonService } from './person.service';
import { IPersonalData } from 'app/shared/model/personal-data.model';
import { PersonalDataService } from 'app/entities/personal-data';
import { IAddress } from 'app/shared/model/address.model';
import { AddressService } from 'app/entities/address';

@Component({
    selector: 'jhi-person-update',
    templateUrl: './person-update.component.html'
})
export class PersonUpdateComponent implements OnInit {
    private _person: IPerson;
    isSaving: boolean;

    personaldata: IPersonalData[];

    addresses: IAddress[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private personService: PersonService,
        private personalDataService: PersonalDataService,
        private addressService: AddressService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ person }) => {
            this.person = person;
        });
        this.personalDataService.query({ filter: 'person-is-null' }).subscribe(
            (res: HttpResponse<IPersonalData[]>) => {
                if (!this.person.personalDataId) {
                    this.personaldata = res.body;
                } else {
                    this.personalDataService.find(this.person.personalDataId).subscribe(
                        (subRes: HttpResponse<IPersonalData>) => {
                            this.personaldata = [subRes.body].concat(res.body);
                        },
                        (subRes: HttpErrorResponse) => this.onError(subRes.message)
                    );
                }
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.addressService.query({ filter: 'person-is-null' }).subscribe(
            (res: HttpResponse<IAddress[]>) => {
                if (!this.person.addressId) {
                    this.addresses = res.body;
                } else {
                    this.addressService.find(this.person.addressId).subscribe(
                        (subRes: HttpResponse<IAddress>) => {
                            this.addresses = [subRes.body].concat(res.body);
                        },
                        (subRes: HttpErrorResponse) => this.onError(subRes.message)
                    );
                }
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.person.id !== undefined) {
            this.subscribeToSaveResponse(this.personService.update(this.person));
        } else {
            this.subscribeToSaveResponse(this.personService.create(this.person));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IPerson>>) {
        result.subscribe((res: HttpResponse<IPerson>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackPersonalDataById(index: number, item: IPersonalData) {
        return item.id;
    }

    trackAddressById(index: number, item: IAddress) {
        return item.id;
    }
    get person() {
        return this._person;
    }

    set person(person: IPerson) {
        this._person = person;
    }
}
