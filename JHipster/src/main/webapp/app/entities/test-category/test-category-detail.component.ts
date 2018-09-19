import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { ITestCategory } from 'app/shared/model/test-category.model';

@Component({
    selector: 'jhi-test-category-detail',
    templateUrl: './test-category-detail.component.html'
})
export class TestCategoryDetailComponent implements OnInit {
    testCategory: ITestCategory;

    constructor(private activatedRoute: ActivatedRoute) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ testCategory }) => {
            this.testCategory = testCategory;
        });
    }

    previousState() {
        window.history.back();
    }
}
