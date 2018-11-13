import { Component, OnInit } from '@angular/core';
import {AbstractControl, FormArray, FormControl, FormGroup, Validators} from '@angular/forms';
import {User, IUser} from '../../../../entities/user';
import {ActivatedRoute} from '@angular/router';
import {UserService} from '../../../../services/user.service';
import {Observable, zip} from 'rxjs';
import {map} from 'rxjs/operators';
import {HttpResponse} from '@angular/common/http';
import {RxjsUtils} from '../../../../utils/rxjs.utils';

@Component({
  selector: 'app-edit',
  templateUrl: './users-edit.component.html',
  styleUrls: ['./users-edit.component.scss']
})
export class UsersEditComponent implements OnInit {

  user: IUser;
  userLogin: string;

  constructor(private activatedRoute: ActivatedRoute,
              private userService: UserService) { }

  ngOnInit() {

    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.userLogin = params['login'];

      const getUser$ = this.getUser(this.userLogin);

      getUser$.subscribe((user: IUser) => {
        this.user = user;
      });

    });
  }

  onItemSelect(item: any) {
    console.log(item);
  }
  onSelectAll(items: any) {
    console.log(items);
  }


  getUser(userLogin: string): Observable<IUser> {
    if (userLogin) {
      return this.userService.find(userLogin).pipe(map((userResponse: HttpResponse<IUser>) => {
        return userResponse.body;
      }));

    } else {
      return RxjsUtils.create(new User());
    }
  }
}
