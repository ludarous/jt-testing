import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { TestResult } from 'app/shared/model/test-result.model';
import { TestResultService } from './test-result.service';
import { TestResultComponent } from './test-result.component';
import { TestResultDetailComponent } from './test-result-detail.component';
import { TestResultUpdateComponent } from './test-result-update.component';
import { TestResultDeletePopupComponent } from './test-result-delete-dialog.component';
import { ITestResult } from 'app/shared/model/test-result.model';

@Injectable({ providedIn: 'root' })
export class TestResultResolve implements Resolve<ITestResult> {
    constructor(private service: TestResultService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((testResult: HttpResponse<TestResult>) => testResult.body));
        }
        return of(new TestResult());
    }
}

export const testResultRoute: Routes = [
    {
        path: 'test-result',
        component: TestResultComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'jtTestingApp.testResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'test-result/:id/view',
        component: TestResultDetailComponent,
        resolve: {
            testResult: TestResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.testResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'test-result/new',
        component: TestResultUpdateComponent,
        resolve: {
            testResult: TestResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.testResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'test-result/:id/edit',
        component: TestResultUpdateComponent,
        resolve: {
            testResult: TestResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.testResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const testResultPopupRoute: Routes = [
    {
        path: 'test-result/:id/delete',
        component: TestResultDeletePopupComponent,
        resolve: {
            testResult: TestResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.testResult.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
