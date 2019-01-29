import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { IActivityGroupResult } from 'app/shared/model/activity-group-result.model';

type EntityResponseType = HttpResponse<IActivityGroupResult>;
type EntityArrayResponseType = HttpResponse<IActivityGroupResult[]>;

@Injectable({ providedIn: 'root' })
export class ActivityGroupResultService {
    private resourceUrl = SERVER_API_URL + 'api/activity-group-results';
    private resourceSearchUrl = SERVER_API_URL + 'api/_search/activity-group-results';

    constructor(private http: HttpClient) {}

    create(activityGroupResult: IActivityGroupResult): Observable<EntityResponseType> {
        return this.http.post<IActivityGroupResult>(this.resourceUrl, activityGroupResult, { observe: 'response' });
    }

    update(activityGroupResult: IActivityGroupResult): Observable<EntityResponseType> {
        return this.http.put<IActivityGroupResult>(this.resourceUrl, activityGroupResult, { observe: 'response' });
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http.get<IActivityGroupResult>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IActivityGroupResult[]>(this.resourceUrl, { params: options, observe: 'response' });
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    search(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IActivityGroupResult[]>(this.resourceSearchUrl, { params: options, observe: 'response' });
    }
}
