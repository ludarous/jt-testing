import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JhiAlertService } from 'ng-jhipster';

import { IEventResult } from 'app/shared/model/event-result.model';
import { EventResultService } from './event-result.service';
import { IEvent } from 'app/shared/model/event.model';
import { EventService } from 'app/entities/event';
import { IPerson } from 'app/shared/model/person.model';
import { PersonService } from 'app/entities/person';

@Component({
    selector: 'jhi-event-result-update',
    templateUrl: './event-result-update.component.html'
})
export class EventResultUpdateComponent implements OnInit {
    private _eventResult: IEventResult;
    isSaving: boolean;

    events: IEvent[];

    people: IPerson[];

    constructor(
        private jhiAlertService: JhiAlertService,
        private eventResultService: EventResultService,
        private eventService: EventService,
        private personService: PersonService,
        private activatedRoute: ActivatedRoute
    ) {}

    ngOnInit() {
        this.isSaving = false;
        this.activatedRoute.data.subscribe(({ eventResult }) => {
            this.eventResult = eventResult;
        });
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
        if (this.eventResult.id !== undefined) {
            this.subscribeToSaveResponse(this.eventResultService.update(this.eventResult));
        } else {
            this.subscribeToSaveResponse(this.eventResultService.create(this.eventResult));
        }
    }

    private subscribeToSaveResponse(result: Observable<HttpResponse<IEventResult>>) {
        result.subscribe((res: HttpResponse<IEventResult>) => this.onSaveSuccess(), (res: HttpErrorResponse) => this.onSaveError());
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

    trackEventById(index: number, item: IEvent) {
        return item.id;
    }

    trackPersonById(index: number, item: IPerson) {
        return item.id;
    }
    get eventResult() {
        return this._eventResult;
    }

    set eventResult(eventResult: IEventResult) {
        this._eventResult = eventResult;
    }
}
