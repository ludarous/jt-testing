import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IActivityGroup } from 'app/shared/model/activity-group.model';

@Component({
    selector: 'jhi-activity-group-detail',
    templateUrl: './activity-group-detail.component.html'
})
export class ActivityGroupDetailComponent implements OnInit {
    activityGroup: IActivityGroup;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ activityGroup }) => {
            this.activityGroup = activityGroup;
        });
    }

    previousState() {
        window.history.back();
    }
}
