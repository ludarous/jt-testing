import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { EventResult } from 'app/shared/model/event-result.model';
import { EventResultService } from './event-result.service';
import { EventResultComponent } from './event-result.component';
import { EventResultDetailComponent } from './event-result-detail.component';
import { EventResultUpdateComponent } from './event-result-update.component';
import { EventResultDeletePopupComponent } from './event-result-delete-dialog.component';
import { IEventResult } from 'app/shared/model/event-result.model';

@Injectable({ providedIn: 'root' })
export class EventResultResolve implements Resolve<IEventResult> {
    constructor(private service: EventResultService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((eventResult: HttpResponse<EventResult>) => eventResult.body));
        }
        return of(new EventResult());
    }
}

export const eventResultRoute: Routes = [
    {
        path: 'event-result',
        component: EventResultComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'activityGroupingApp.eventResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'event-result/:id/view',
        component: EventResultDetailComponent,
        resolve: {
            eventResult: EventResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'activityGroupingApp.eventResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'event-result/new',
        component: EventResultUpdateComponent,
        resolve: {
            eventResult: EventResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'activityGroupingApp.eventResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'event-result/:id/edit',
        component: EventResultUpdateComponent,
        resolve: {
            eventResult: EventResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'activityGroupingApp.eventResult.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const eventResultPopupRoute: Routes = [
    {
        path: 'event-result/:id/delete',
        component: EventResultDeletePopupComponent,
        resolve: {
            eventResult: EventResultResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'activityGroupingApp.eventResult.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
