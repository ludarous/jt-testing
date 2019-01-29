import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { ActivityGroupResult } from 'app/shared/model/activity-group-result.model';
import { ActivityGroupResultService } from './activity-group-result.service';
import { ActivityGroupResultComponent } from './activity-group-result.component';
import { ActivityGroupResultDetailComponent } from './activity-group-result-detail.component';
import { ActivityGroupResultUpdateComponent } from './activity-group-result-update.component';
import { ActivityGroupResultDeletePopupComponent } from './activity-group-result-delete-dialog.component';
import { IActivityGroupResult } from 'app/shared/model/activity-group-result.model';

@Injectable({ providedIn: 'root' })
export class ActivityGroupResultResolve implements Resolve<IActivityGroupResult> {
    constructor(private service: ActivityGroupResultService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((activityGroupResult: HttpResponse<ActivityGroupResult>) => activityGroupResult.body));
        }
        return of(new ActivityGroupResult());
    }
}

export const activityGroupResultRoute: Routes = [
    {
        path: 'activity-group-result',
        component: ActivityGroupResultComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'jtTestingApp.activityGroupResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group-result/:id/view',
        component: ActivityGroupResultDetailComponent,
        resolve: {
            activityGroupResult: ActivityGroupResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroupResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group-result/new',
        component: ActivityGroupResultUpdateComponent,
        resolve: {
            activityGroupResult: ActivityGroupResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroupResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group-result/:id/edit',
        component: ActivityGroupResultUpdateComponent,
        resolve: {
            activityGroupResult: ActivityGroupResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroupResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const activityGroupResultPopupRoute: Routes = [
    {
        path: 'activity-group-result/:id/delete',
        component: ActivityGroupResultDeletePopupComponent,
        resolve: {
            activityGroupResult: ActivityGroupResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroupResult.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
