import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import * as moment from 'moment';
import { DATE_FORMAT } from 'app/shared/constants/input.constants';
import { map } from 'rxjs/operators';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { IPersonalData } from 'app/shared/model/personal-data.model';

type EntityResponseType = HttpResponse<IPersonalData>;
type EntityArrayResponseType = HttpResponse<IPersonalData[]>;

@Injectable({ providedIn: 'root' })
export class PersonalDataService {
    private resourceUrl = SERVER_API_URL + 'api/personal-data';
    private resourceSearchUrl = SERVER_API_URL + 'api/_search/personal-data';

    constructor(private http: HttpClient) {}

    create(personalData: IPersonalData): Observable<EntityResponseType> {
        const copy = this.convertDateFromClient(personalData);
        return this.http
            .post<IPersonalData>(this.resourceUrl, copy, { observe: 'response' })
            .pipe(map((res: EntityResponseType) => this.convertDateFromServer(res)));
    }

    update(personalData: IPersonalData): Observable<EntityResponseType> {
        const copy = this.convertDateFromClient(personalData);
        return this.http
            .put<IPersonalData>(this.resourceUrl, copy, { observe: 'response' })
            .pipe(map((res: EntityResponseType) => this.convertDateFromServer(res)));
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http
            .get<IPersonalData>(`${this.resourceUrl}/${id}`, { observe: 'response' })
            .pipe(map((res: EntityResponseType) => this.convertDateFromServer(res)));
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http
            .get<IPersonalData[]>(this.resourceUrl, { params: options, observe: 'response' })
            .pipe(map((res: EntityArrayResponseType) => this.convertDateArrayFromServer(res)));
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    search(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http
            .get<IPersonalData[]>(this.resourceSearchUrl, { params: options, observe: 'response' })
            .pipe(map((res: EntityArrayResponseType) => this.convertDateArrayFromServer(res)));
    }

    private convertDateFromClient(personalData: IPersonalData): IPersonalData {
        const copy: IPersonalData = Object.assign({}, personalData, {
            birthDate: personalData.birthDate != null && personalData.birthDate.isValid() ? personalData.birthDate.toJSON() : null
        });
        return copy;
    }

    private convertDateFromServer(res: EntityResponseType): EntityResponseType {
        res.body.birthDate = res.body.birthDate != null ? moment(res.body.birthDate) : null;
        return res;
    }

    private convertDateArrayFromServer(res: EntityArrayResponseType): EntityArrayResponseType {
        res.body.forEach((personalData: IPersonalData) => {
            personalData.birthDate = personalData.birthDate != null ? moment(personalData.birthDate) : null;
        });
        return res;
    }
}
