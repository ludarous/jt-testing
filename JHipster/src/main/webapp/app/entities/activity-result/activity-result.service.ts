import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import * as moment from 'moment';
import { DATE_FORMAT } from 'app/shared/constants/input.constants';
import { map } from 'rxjs/operators';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { IActivityResult } from 'app/shared/model/activity-result.model';

type EntityResponseType = HttpResponse<IActivityResult>;
type EntityArrayResponseType = HttpResponse<IActivityResult[]>;

@Injectable({ providedIn: 'root' })
export class ActivityResultService {
    private resourceUrl = SERVER_API_URL + 'api/activity-results';
    private resourceSearchUrl = SERVER_API_URL + 'api/_search/activity-results';

    constructor(private http: HttpClient) {}

    create(activityResult: IActivityResult): Observable<EntityResponseType> {
        const copy = this.convertDateFromClient(activityResult);
        return this.http
            .post<IActivityResult>(this.resourceUrl, copy, { observe: 'response' })
            .pipe(map((res: EntityResponseType) => this.convertDateFromServer(res)));
    }

    update(activityResult: IActivityResult): Observable<EntityResponseType> {
        const copy = this.convertDateFromClient(activityResult);
        return this.http
            .put<IActivityResult>(this.resourceUrl, copy, { observe: 'response' })
            .pipe(map((res: EntityResponseType) => this.convertDateFromServer(res)));
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http
            .get<IActivityResult>(`${this.resourceUrl}/${id}`, { observe: 'response' })
            .pipe(map((res: EntityResponseType) => this.convertDateFromServer(res)));
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http
            .get<IActivityResult[]>(this.resourceUrl, { params: options, observe: 'response' })
            .pipe(map((res: EntityArrayResponseType) => this.convertDateArrayFromServer(res)));
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    search(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http
            .get<IActivityResult[]>(this.resourceSearchUrl, { params: options, observe: 'response' })
            .pipe(map((res: EntityArrayResponseType) => this.convertDateArrayFromServer(res)));
    }

    private convertDateFromClient(activityResult: IActivityResult): IActivityResult {
        const copy: IActivityResult = Object.assign({}, activityResult, {
            eventDate: activityResult.eventDate != null && activityResult.eventDate.isValid() ? activityResult.eventDate.toJSON() : null
        });
        return copy;
    }

    private convertDateFromServer(res: EntityResponseType): EntityResponseType {
        res.body.eventDate = res.body.eventDate != null ? moment(res.body.eventDate) : null;
        return res;
    }

    private convertDateArrayFromServer(res: EntityArrayResponseType): EntityArrayResponseType {
        res.body.forEach((activityResult: IActivityResult) => {
            activityResult.eventDate = activityResult.eventDate != null ? moment(activityResult.eventDate) : null;
        });
        return res;
    }
}
