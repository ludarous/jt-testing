import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { JTTest } from 'app/shared/model/jt-test.model';
import { JTTestService } from './jt-test.service';
import { JTTestComponent } from './jt-test.component';
import { JTTestDetailComponent } from './jt-test-detail.component';
import { JTTestUpdateComponent } from './jt-test-update.component';
import { JTTestDeletePopupComponent } from './jt-test-delete-dialog.component';
import { IJTTest } from 'app/shared/model/jt-test.model';

@Injectable({ providedIn: 'root' })
export class JTTestResolve implements Resolve<IJTTest> {
    constructor(private service: JTTestService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((jTTest: HttpResponse<JTTest>) => jTTest.body));
        }
        return of(new JTTest());
    }
}

export const jTTestRoute: Routes = [
    {
        path: 'jt-test',
        component: JTTestComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'jtTestingApp.jTTest.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'jt-test/:id/view',
        component: JTTestDetailComponent,
        resolve: {
            jTTest: JTTestResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.jTTest.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'jt-test/new',
        component: JTTestUpdateComponent,
        resolve: {
            jTTest: JTTestResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.jTTest.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'jt-test/:id/edit',
        component: JTTestUpdateComponent,
        resolve: {
            jTTest: JTTestResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.jTTest.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const jTTestPopupRoute: Routes = [
    {
        path: 'jt-test/:id/delete',
        component: JTTestDeletePopupComponent,
        resolve: {
            jTTest: JTTestResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.jTTest.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
