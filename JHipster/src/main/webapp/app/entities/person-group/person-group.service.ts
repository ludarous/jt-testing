import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { IPersonGroup } from 'app/shared/model/person-group.model';

type EntityResponseType = HttpResponse<IPersonGroup>;
type EntityArrayResponseType = HttpResponse<IPersonGroup[]>;

@Injectable({ providedIn: 'root' })
export class PersonGroupService {
    private resourceUrl = SERVER_API_URL + 'api/person-groups';
    private resourceSearchUrl = SERVER_API_URL + 'api/_search/person-groups';

    constructor(private http: HttpClient) {}

    create(personGroup: IPersonGroup): Observable<EntityResponseType> {
        return this.http.post<IPersonGroup>(this.resourceUrl, personGroup, { observe: 'response' });
    }

    update(personGroup: IPersonGroup): Observable<EntityResponseType> {
        return this.http.put<IPersonGroup>(this.resourceUrl, personGroup, { observe: 'response' });
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http.get<IPersonGroup>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IPersonGroup[]>(this.resourceUrl, { params: options, observe: 'response' });
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    search(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IPersonGroup[]>(this.resourceSearchUrl, { params: options, observe: 'response' });
    }
}
