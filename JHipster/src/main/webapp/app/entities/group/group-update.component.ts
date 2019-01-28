import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { IGroup } from 'app/shared/model/group.model';
import { GroupService } from './group.service';

@Component({
    selector: 'jhi-group-update',
    templateUrl: './group-update.component.html'
})
export class GroupUpdateComponent implements OnInit {
    private _group: IGroup;
    isSaving: boolean;

    groups: IGroup[];

    constructor(private jhiAlertService: JhiAlertService, private groupService: GroupService, private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ group }) => {
            this.group = group;
        });
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
        if (this.group.id !== undefined) {
            this.subscribeToSaveResponse(this.groupService.update(this.group));
        } else {
            this.subscribeToSaveResponse(this.groupService.create(this.group));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IGroup>>) {
        result.subscribe((res: HttpResponse<IGroup>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackGroupById(index: number, item: IGroup) {
        return item.id;
    }
    get group() {
        return this._group;
    }

    set group(group: IGroup) {
        this._group = group;
    }
}
