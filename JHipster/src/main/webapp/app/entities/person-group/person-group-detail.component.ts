import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IPersonGroup } from 'app/shared/model/person-group.model';

@Component({
    selector: 'jhi-person-group-detail',
    templateUrl: './person-group-detail.component.html'
})
export class PersonGroupDetailComponent implements OnInit {
    personGroup: IPersonGroup;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ personGroup }) => {
            this.personGroup = personGroup;
        });
    }

    previousState() {
        window.history.back();
    }
}
