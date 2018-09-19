import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { JhiPaginationUtil, JhiResolvePagingParams } from 'ng-jhipster';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { PersonalData } from 'app/shared/model/personal-data.model';
import { PersonalDataService } from './personal-data.service';
import { PersonalDataComponent } from './personal-data.component';
import { PersonalDataDetailComponent } from './personal-data-detail.component';
import { PersonalDataUpdateComponent } from './personal-data-update.component';
import { PersonalDataDeletePopupComponent } from './personal-data-delete-dialog.component';
import { IPersonalData } from 'app/shared/model/personal-data.model';

@Injectable({ providedIn: 'root' })
export class PersonalDataResolve implements Resolve<IPersonalData> {
    constructor(private service: PersonalDataService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((personalData: HttpResponse<PersonalData>) => personalData.body));
        }
        return of(new PersonalData());
    }
}

export const personalDataRoute: Routes = [
    {
        path: 'personal-data',
        component: PersonalDataComponent,
        resolve: {
            pagingParams: JhiResolvePagingParams
        },
        data: {
            authorities: ['ROLE_USER'],
            defaultSort: 'id,asc',
            pageTitle: 'jtTestingApp.personalData.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'personal-data/:id/view',
        component: PersonalDataDetailComponent,
        resolve: {
            personalData: PersonalDataResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.personalData.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'personal-data/new',
        component: PersonalDataUpdateComponent,
        resolve: {
            personalData: PersonalDataResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.personalData.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'personal-data/:id/edit',
        component: PersonalDataUpdateComponent,
        resolve: {
            personalData: PersonalDataResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.personalData.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const personalDataPopupRoute: Routes = [
    {
        path: 'personal-data/:id/delete',
        component: PersonalDataDeletePopupComponent,
        resolve: {
            personalData: PersonalDataResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.personalData.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
