import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { Workout } from 'app/shared/model/activity-group.model';
import { WorkoutService } from './workout.service';
import { WorkoutComponent } from './workout.component';
import { WorkoutDetailComponent } from './workout-detail.component';
import { WorkoutUpdateComponent } from './workout-update.component';
import { WorkoutDeletePopupComponent } from './workout-delete-dialog.component';
import { IWorkout } from 'app/shared/model/activity-group.model';

@Injectable({ providedIn: 'root' })
export class WorkoutResolve implements Resolve<IWorkout> {
    constructor(private service: WorkoutService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((workout: HttpResponse<Workout>) => workout.body));
        }
        return of(new Workout());
    }
}

export const workoutRoute: Routes = [
    {
        path: 'activity-group',
        component: WorkoutComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'jtTestingApp.workout.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group/:id/view',
        component: WorkoutDetailComponent,
        resolve: {
            workout: WorkoutResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workout.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group/new',
        component: WorkoutUpdateComponent,
        resolve: {
            workout: WorkoutResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workout.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'activity-group/:id/edit',
        component: WorkoutUpdateComponent,
        resolve: {
            workout: WorkoutResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workout.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const workoutPopupRoute: Routes = [
    {
        path: 'activity-group/:id/delete',
        component: WorkoutDeletePopupComponent,
        resolve: {
            workout: WorkoutResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workout.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
