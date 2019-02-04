import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { SERVER_API_URL } from 'app/app.constants';
import { createRequestOption } from 'app/shared';
import { IWorkoutResult } from 'app/shared/model/activity-group-result.model';

type EntityResponseType = HttpResponse<IWorkoutResult>;
type EntityArrayResponseType = HttpResponse<IWorkoutResult[]>;

@Injectable({ providedIn: 'root' })
export class WorkoutResultService {
    private resourceUrl = SERVER_API_URL + 'api/activity-group-results';
    private resourceSearchUrl = SERVER_API_URL + 'api/_search/activity-group-results';

    constructor(private http: HttpClient) {}

    create(workoutResult: IWorkoutResult): Observable<EntityResponseType> {
        return this.http.post<IWorkoutResult>(this.resourceUrl, workoutResult, { observe: 'response' });
    }

    update(workoutResult: IWorkoutResult): Observable<EntityResponseType> {
        return this.http.put<IWorkoutResult>(this.resourceUrl, workoutResult, { observe: 'response' });
    }

    find(id: number): Observable<EntityResponseType> {
        return this.http.get<IWorkoutResult>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    query(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IWorkoutResult[]>(this.resourceUrl, { params: options, observe: 'response' });
    }

    delete(id: number): Observable<HttpResponse<any>> {
        return this.http.delete<any>(`${this.resourceUrl}/${id}`, { observe: 'response' });
    }

    search(req?: any): Observable<EntityArrayResponseType> {
        const options = createRequestOption(req);
        return this.http.get<IWorkoutResult[]>(this.resourceSearchUrl, { params: options, observe: 'response' });
    }
}
