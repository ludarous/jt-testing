import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { IPersonGroup } from 'app/shared/model/person-group.model';
import { PersonGroupService } from './person-group.service';
import { IPerson } from 'app/shared/model/person.model';
import { PersonService } from 'app/entities/person';
import { IGroup } from 'app/shared/model/group.model';
import { GroupService } from 'app/entities/group';

@Component({
    selector: 'jhi-person-group-update',
    templateUrl: './person-group-update.component.html'
})
export class PersonGroupUpdateComponent implements OnInit {
    private _personGroup: IPersonGroup;
    isSaving: boolean;

    people: IPerson[];

    groups: IGroup[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private personGroupService: PersonGroupService,
        private personService: PersonService,
        private groupService: GroupService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ personGroup }) => {
            this.personGroup = personGroup;
        });
        this.personService.query().subscribe(
            (res: HttpResponse<IPerson[]>) => {
                this.people = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
        this.groupService.query().subscribe(
            (res: HttpResponse<IGroup[]>) => {
                this.groups = res.body;
            },
            (res: HttpErrorResponse) => this.onError(res.message)
        );
    }

    previousState() {
        window.history.back();
    }

    save() {
        this.isSaving = true;
        if (this.personGroup.id !== undefined) {
            this.subscribeToSaveResponse(this.personGroupService.update(this.personGroup));
        } else {
            this.subscribeToSaveResponse(this.personGroupService.create(this.personGroup));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IPersonGroup>>) {
        result.subscribe((res: HttpResponse<IPersonGroup>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackPersonById(index: number, item: IPerson) {
        return item.id;
    }

    trackGroupById(index: number, item: IGroup) {
        return item.id;
    }
    get personGroup() {
        return this._personGroup;
    }

    set personGroup(personGroup: IPersonGroup) {
        this._personGroup = personGroup;
    }
}
