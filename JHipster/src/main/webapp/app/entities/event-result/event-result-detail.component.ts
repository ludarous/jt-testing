import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IEventResult } from 'app/shared/model/event-result.model';

@Component({
    selector: 'jhi-event-result-detail',
    templateUrl: './event-result-detail.component.html'
})
export class EventResultDetailComponent implements OnInit {
    eventResult: IEventResult;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ eventResult }) => {
            this.eventResult = eventResult;
        });
    }

    previousState() {
        window.history.back();
    }
}
