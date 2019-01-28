import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { IActivityGroupCategory } from 'app/shared/model/activity-group-category.model';

type EntityResponseType = HttpResponse<IActivityGroupCategory>;
type EntityArrayResponseType = HttpResponse<IActivityGroupCategory[]>;

@Injectable({ providedIn: 'root' })
export class ActivityGroupCategoryService {
    private resourceUrl = SERVER_API_URL + 'api/activity-group-categories';
    private resourceSearchUrl = SERVER_API_URL + 'api/_search/activity-group-categories';

    constructor(private http: HttpClient) {}

    create(activityGroupCategory: IActivityGroupCategory): Observable<EntityResponseType> {
        return this.http.post<IActivityGroupCategory>(this.resourceUrl, activityGroupCategory, { observe: 'response' });
    }

    update(activityGroupCategory: IActivityGroupCategory): Observable<EntityResponseType> {
        return this.http.put<IActivityGroupCategory>(this.resourceUrl, activityGroupCategory, { observe: 'response' });
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http.get<IActivityGroupCategory>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IActivityGroupCategory[]>(this.resourceUrl, { params: options, observe: 'response' });
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    search(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IActivityGroupCategory[]>(this.resourceSearchUrl, { params: options, observe: 'response' });
    }
}
