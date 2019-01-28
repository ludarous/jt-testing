import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { ActivityGroup } from 'app/shared/model/activity-group.model';
import { ActivityGroupService } from './activity-group.service';
import { ActivityGroupComponent } from './activity-group.component';
import { ActivityGroupDetailComponent } from './activity-group-detail.component';
import { ActivityGroupUpdateComponent } from './activity-group-update.component';
import { ActivityGroupDeletePopupComponent } from './activity-group-delete-dialog.component';
import { IActivityGroup } from 'app/shared/model/activity-group.model';

@Injectable({ providedIn: 'root' })
export class ActivityGroupResolve implements Resolve<IActivityGroup> {
    constructor(private service: ActivityGroupService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((activityGroup: HttpResponse<ActivityGroup>) => activityGroup.body));
        }
        return of(new ActivityGroup());
    }
}

export const activityGroupRoute: Routes = [
    {
        path: 'activity-group',
        component: ActivityGroupComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'jtTestingApp.activityGroup.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group/:id/view',
        component: ActivityGroupDetailComponent,
        resolve: {
            activityGroup: ActivityGroupResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroup.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group/new',
        component: ActivityGroupUpdateComponent,
        resolve: {
            activityGroup: ActivityGroupResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroup.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group/:id/edit',
        component: ActivityGroupUpdateComponent,
        resolve: {
            activityGroup: ActivityGroupResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroup.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const activityGroupPopupRoute: Routes = [
    {
        path: 'activity-group/:id/delete',
        component: ActivityGroupDeletePopupComponent,
        resolve: {
            activityGroup: ActivityGroupResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroup.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
