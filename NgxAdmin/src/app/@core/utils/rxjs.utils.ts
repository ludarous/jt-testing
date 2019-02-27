import {Observable} from 'rxjs';

export class  RxjsUtils {

  static create(obj: any): Observable<any> {
    return Observable.create((observer) => {
      observer.next(obj);
    });
  }
}
