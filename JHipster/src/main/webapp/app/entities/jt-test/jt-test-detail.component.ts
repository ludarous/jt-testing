import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { IJTTest } from 'app/shared/model/jt-test.model';

@Component({
    selector: 'jhi-jt-test-detail',
    templateUrl: './jt-test-detail.component.html'
})
export class JTTestDetailComponent implements OnInit {
    jTTest: IJTTest;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ jTTest }) => {
            this.jTTest = jTTest;
        });
    }

    previousState() {
        window.history.back();
    }
}
