import { Injectable } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot, Routes } from '@angular/router';
import { UserRouteAccessService } from 'app/core';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';
import { PersonGroup } from 'app/shared/model/person-group.model';
import { PersonGroupService } from './person-group.service';
import { PersonGroupComponent } from './person-group.component';
import { PersonGroupDetailComponent } from './person-group-detail.component';
import { PersonGroupUpdateComponent } from './person-group-update.component';
import { PersonGroupDeletePopupComponent } from './person-group-delete-dialog.component';
import { IPersonGroup } from 'app/shared/model/person-group.model';

@Injectable({ providedIn: 'root' })
export class PersonGroupResolve implements Resolve<IPersonGroup> {
    constructor(private service: PersonGroupService) {}

    resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        const id = route.params['id'] ? route.params['id'] : null;
        if (id) {
            return this.service.find(id).pipe(map((personGroup: HttpResponse<PersonGroup>) => personGroup.body));
        }
        return of(new PersonGroup());
    }
}

export const personGroupRoute: Routes = [
    {
        path: 'person-group',
        component: PersonGroupComponent,
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.personGroup.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'person-group/:id/view',
        component: PersonGroupDetailComponent,
        resolve: {
            personGroup: PersonGroupResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.personGroup.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'person-group/new',
        component: PersonGroupUpdateComponent,
        resolve: {
            personGroup: PersonGroupResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.personGroup.home.title'
        },
        canActivate: [UserRouteAccessService]
    },
    {
        path: 'person-group/:id/edit',
        component: PersonGroupUpdateComponent,
        resolve: {
            personGroup: PersonGroupResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.personGroup.home.title'
        },
        canActivate: [UserRouteAccessService]
    }
];

export const personGroupPopupRoute: Routes = [
    {
        path: 'person-group/:id/delete',
        component: PersonGroupDeletePopupComponent,
        resolve: {
            personGroup: PersonGroupResolve
        },
        data: {
            authorities: ['ROLE_USER'],
            pageTitle: 'jtTestingApp.personGroup.home.title'
        },
        canActivate: [UserRouteAccessService],
        outlet: 'popup'
    }
];
