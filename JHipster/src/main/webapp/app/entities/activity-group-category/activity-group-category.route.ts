import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { ActivityGroupCategory } from 'app/shared/model/activity-group-category.model';
import { ActivityGroupCategoryService } from './activity-group-category.service';
import { ActivityGroupCategoryComponent } from './activity-group-category.component';
import { ActivityGroupCategoryDetailComponent } from './activity-group-category-detail.component';
import { ActivityGroupCategoryUpdateComponent } from './activity-group-category-update.component';
import { ActivityGroupCategoryDeletePopupComponent } from './activity-group-category-delete-dialog.component';
import { IActivityGroupCategory } from 'app/shared/model/activity-group-category.model';

@Injectable({ providedIn: 'root' })
export class ActivityGroupCategoryResolve implements Resolve<IActivityGroupCategory> {
    constructor(private service: ActivityGroupCategoryService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service
                .find(id)
                .pipe(map((activityGroupCategory: HttpResponse<ActivityGroupCategory>) => activityGroupCategory.body));
        }
        return of(new ActivityGroupCategory());
    }
}

export const activityGroupCategoryRoute: Routes = [
    {
        path: 'activity-group-category',
        component: ActivityGroupCategoryComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'jtTestingApp.activityGroupCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group-category/:id/view',
        component: ActivityGroupCategoryDetailComponent,
        resolve: {
            activityGroupCategory: ActivityGroupCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroupCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group-category/new',
        component: ActivityGroupCategoryUpdateComponent,
        resolve: {
            activityGroupCategory: ActivityGroupCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroupCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group-category/:id/edit',
        component: ActivityGroupCategoryUpdateComponent,
        resolve: {
            activityGroupCategory: ActivityGroupCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroupCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const activityGroupCategoryPopupRoute: Routes = [
    {
        path: 'activity-group-category/:id/delete',
        component: ActivityGroupCategoryDeletePopupComponent,
        resolve: {
            activityGroupCategory: ActivityGroupCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.activityGroupCategory.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
