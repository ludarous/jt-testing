import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { WorkoutResult } from 'app/shared/model/workout-result.model';
import { WorkoutResultService } from './workout-result.service';
import { WorkoutResultComponent } from './workout-result.component';
import { WorkoutResultDetailComponent } from './workout-result-detail.component';
import { WorkoutResultUpdateComponent } from './workout-result-update.component';
import { WorkoutResultDeletePopupComponent } from './workout-result-delete-dialog.component';
import { IWorkoutResult } from 'app/shared/model/workout-result.model';

@Injectable({ providedIn: 'root' })
export class WorkoutResultResolve implements Resolve<IWorkoutResult> {
    constructor(private service: WorkoutResultService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((workoutResult: HttpResponse<WorkoutResult>) => workoutResult.body));
        }
        return of(new WorkoutResult());
    }
}

export const workoutResultRoute: Routes = [
    {
        path: 'workout-result',
        component: WorkoutResultComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'jtTestingApp.workoutResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'workout-result/:id/view',
        component: WorkoutResultDetailComponent,
        resolve: {
            workoutResult: WorkoutResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workoutResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'workout-result/new',
        component: WorkoutResultUpdateComponent,
        resolve: {
            workoutResult: WorkoutResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workoutResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'workout-result/:id/edit',
        component: WorkoutResultUpdateComponent,
        resolve: {
            workoutResult: WorkoutResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workoutResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const workoutResultPopupRoute: Routes = [
    {
        path: 'workout-result/:id/delete',
        component: WorkoutResultDeletePopupComponent,
        resolve: {
            workoutResult: WorkoutResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.workoutResult.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
