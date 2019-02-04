import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { WorkoutCategory } from 'app/shared/model/activity-group-category.model';
import { WorkoutCategoryService } from './workout-category.service';
import { WorkoutCategoryComponent } from './workout-category.component';
import { WorkoutCategoryDetailComponent } from './workout-category-detail.component';
import { WorkoutCategoryUpdateComponent } from './workout-category-update.component';
import { WorkoutCategoryDeletePopupComponent } from './workout-category-delete-dialog.component';
import { IWorkoutCategory } from 'app/shared/model/activity-group-category.model';

@Injectable({ providedIn: 'root' })
export class WorkoutCategoryResolve implements Resolve<IWorkoutCategory> {
    constructor(private service: WorkoutCategoryService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service
                .find(id)
                .pipe(map((workoutCategory: HttpResponse<WorkoutCategory>) => workoutCategory.body));
        }
        return of(new WorkoutCategory());
    }
}

export const workoutCategoryRoute: Routes = [
    {
        path: 'activity-group-category',
        component: WorkoutCategoryComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'jtTestingApp.workoutCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group-category/:id/view',
        component: WorkoutCategoryDetailComponent,
        resolve: {
            workoutCategory: WorkoutCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workoutCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group-category/new',
        component: WorkoutCategoryUpdateComponent,
        resolve: {
            workoutCategory: WorkoutCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workoutCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group-category/:id/edit',
        component: WorkoutCategoryUpdateComponent,
        resolve: {
            workoutCategory: WorkoutCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workoutCategory.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const workoutCategoryPopupRoute: Routes = [
    {
        path: 'activity-group-category/:id/delete',
        component: WorkoutCategoryDeletePopupComponent,
        resolve: {
            workoutCategory: WorkoutCategoryResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workoutCategory.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
