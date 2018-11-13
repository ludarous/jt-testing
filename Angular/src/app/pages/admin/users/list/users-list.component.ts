import { Component, OnInit } from '@angular/core';
import {HttpResponse} from '@angular/common/http';
import {IActivity} from '../../../../entities/activity';
import {ActivityService} from '../../../../services/activity.service';
import {Router} from '@angular/router';
import {IUser} from '../../../../entities/user';
import {UserService} from '../../../../services/user.service';

@Component({
  selector: 'app-users-list',
  templateUrl: './users-list.component.html',
  styleUrls: ['./users-list.component.scss']
})
export class UsersListComponent implements OnInit {

  tableCols: Array<any>;
  users: Array<IUser>;

  constructor(private userService: UserService,
              private router: Router) { }

  ngOnInit() {

    this.tableCols = [
      { field: 'firstName', header: 'Křestní jméno' },
      { field: 'lastName', header: 'Příjmení' },
      { field: 'login', header: 'Login' },
    ];

    this.userService.query().subscribe((users: HttpResponse<Array<IUser>>) => {
      this.users = users.body;
    });
  }

  rowSelect(user: IUser) {
    this.router.navigate(['/admin/users/edit', user.login]);
  }
}
