import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IActivityGroupResult } from 'app/shared/model/activity-group-result.model';

@Component({
    selector: 'jhi-activity-group-result-detail',
    templateUrl: './activity-group-result-detail.component.html'
})
export class ActivityGroupResultDetailComponent implements OnInit {
    activityGroupResult: IActivityGroupResult;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ activityGroupResult }) => {
            this.activityGroupResult = activityGroupResult;
        });
    }

    previousState() {
        window.history.back();
    }
}
