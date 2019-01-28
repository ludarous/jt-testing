import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IActivityGroupCategory } from 'app/shared/model/activity-group-category.model';

@Component({
    selector: 'jhi-activity-group-category-detail',
    templateUrl: './activity-group-category-detail.component.html'
})
export class ActivityGroupCategoryDetailComponent implements OnInit {
    activityGroupCategory: IActivityGroupCategory;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ activityGroupCategory }) => {
            this.activityGroupCategory = activityGroupCategory;
        });
    }

    previousState() {
        window.history.back();
    }
}
