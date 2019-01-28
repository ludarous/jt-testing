import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { IActivityGroup } from 'app/shared/model/activity-group.model';

type EntityResponseType = HttpResponse<IActivityGroup>;
type EntityArrayResponseType = HttpResponse<IActivityGroup[]>;

@Injectable({ providedIn: 'root' })
export class ActivityGroupService {
    private resourceUrl = SERVER_API_URL + 'api/activity-groups';
    private resourceSearchUrl = SERVER_API_URL + 'api/_search/activity-groups';

    constructor(private http: HttpClient) {}

    create(activityGroup: IActivityGroup): Observable<EntityResponseType> {
        return this.http.post<IActivityGroup>(this.resourceUrl, activityGroup, { observe: 'response' });
    }

    update(activityGroup: IActivityGroup): Observable<EntityResponseType> {
        return this.http.put<IActivityGroup>(this.resourceUrl, activityGroup, { observe: 'response' });
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http.get<IActivityGroup>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IActivityGroup[]>(this.resourceUrl, { params: options, observe: 'response' });
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    search(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IActivityGroup[]>(this.resourceSearchUrl, { params: options, observe: 'response' });
    }
}
