import { Component, OnInit } from '@angular/core';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {IActivity} from '../../../../entities/activity';
import {ActivityService} from '../../../../services/activity.service';
import {Router} from '@angular/router';
import {IUser} from '../../../../entities/user';
import {UserService} from '../../../../services/user.service';
import {PersonService} from '../../../../services/person.service';
import {IPersonFull} from '../../../../entities/person-full';
import {IPerson} from '../../../../entities/person';

@Component({
  selector: 'app-users-list',
  templateUrl: './users-list.component.html',
  styleUrls: ['./users-list.component.scss']
})
export class UsersListComponent implements OnInit {

  persons: Array<IPersonFull>;

  constructor(private userService: UserService,
              private personService: PersonService,
              private router: Router) { }

  ngOnInit() {

    this.personService.queryFull({
      page: 0,
      size: 1000,
    }).subscribe((personsResponse: HttpResponse<Array<IPersonFull>>) => {
      this.persons = personsResponse.body;
    });
  }

  rowSelect(person: IPerson) {
    this.router.navigate(['/admin/users/edit', person.id]);
  }
}
