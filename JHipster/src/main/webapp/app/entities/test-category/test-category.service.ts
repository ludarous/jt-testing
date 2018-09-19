import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { ITestCategory } from 'app/shared/model/test-category.model';

type EntityResponseType = HttpResponse<ITestCategory>;
type EntityArrayResponseType = HttpResponse<ITestCategory[]>;

@Injectable({ providedIn: 'root' })
export class TestCategoryService {
    private resourceUrl = SERVER_API_URL + 'api/test-categories';
    private resourceSearchUrl = SERVER_API_URL + 'api/_search/test-categories';

    constructor(private http: HttpClient) {}

    create(testCategory: ITestCategory): Observable<EntityResponseType> {
        return this.http.post<ITestCategory>(this.resourceUrl, testCategory, { observe: 'response' });
    }

    update(testCategory: ITestCategory): Observable<EntityResponseType> {
        return this.http.put<ITestCategory>(this.resourceUrl, testCategory, { observe: 'response' });
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http.get<ITestCategory>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<ITestCategory[]>(this.resourceUrl, { params: options, observe: 'response' });
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    search(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<ITestCategory[]>(this.resourceSearchUrl, { params: options, observe: 'response' });
    }
}
