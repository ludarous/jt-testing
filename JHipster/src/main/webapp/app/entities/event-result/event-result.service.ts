import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { IEventResult } from 'app/shared/model/event-result.model';

type EntityResponseType = HttpResponse<IEventResult>;
type EntityArrayResponseType = HttpResponse<IEventResult[]>;

@Injectable({ providedIn: 'root' })
export class EventResultService {
    private resourceUrl = SERVER_API_URL + 'api/event-results';
    private resourceSearchUrl = SERVER_API_URL + 'api/_search/event-results';

    constructor(private http: HttpClient) {}

    create(eventResult: IEventResult): Observable<EntityResponseType> {
        return this.http.post<IEventResult>(this.resourceUrl, eventResult, { observe: 'response' });
    }

    update(eventResult: IEventResult): Observable<EntityResponseType> {
        return this.http.put<IEventResult>(this.resourceUrl, eventResult, { observe: 'response' });
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http.get<IEventResult>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IEventResult[]>(this.resourceUrl, { params: options, observe: 'response' });
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    search(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IEventResult[]>(this.resourceSearchUrl, { params: options, observe: 'response' });
    }
}
