import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { TestCategory } from 'app/shared/model/test-category.model';
import { TestCategoryService } from './test-category.service';
import { TestCategoryComponent } from './test-category.component';
import { TestCategoryDetailComponent } from './test-category-detail.component';
import { TestCategoryUpdateComponent } from './test-category-update.component';
import { TestCategoryDeletePopupComponent } from './test-category-delete-dialog.component';
import { ITestCategory } from 'app/shared/model/test-category.model';

@Injectable({ providedIn: 'root' })
export class TestCategoryResolve implements Resolve<ITestCategory> {
    constructor(private service: TestCategoryService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((testCategory: HttpResponse<TestCategory>) => testCategory.body));
        }
        return of(new TestCategory());
    }
}

export const testCategoryRoute: Routes = [
    {
        path: 'test-category',
        component: TestCategoryComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'jtTestingApp.testCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'test-category/:id/view',
        component: TestCategoryDetailComponent,
        resolve: {
            testCategory: TestCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.testCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'test-category/new',
        component: TestCategoryUpdateComponent,
        resolve: {
            testCategory: TestCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.testCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'test-category/:id/edit',
        component: TestCategoryUpdateComponent,
        resolve: {
            testCategory: TestCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.testCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const testCategoryPopupRoute: Routes = [
    {
        path: 'test-category/:id/delete',
        component: TestCategoryDeletePopupComponent,
        resolve: {
            testCategory: TestCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.testCategory.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
