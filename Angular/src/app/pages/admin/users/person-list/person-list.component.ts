import { Component, OnInit } from '@angular/core';
import {HttpResponse} from '@angular/common/http';
import {IActivity} from '../../../../entities/activity';
import {ActivityService} from '../../../../services/activity.service';
import {Router} from '@angular/router';
import {IUser} from '../../../../entities/user';
import {UserService} from '../../../../services/user.service';
import {PersonService} from '../../../../services/person.service';
import {IPersonFull} from '../../../../entities/person-full';

@Component({
  selector: 'app-person-list',
  templateUrl: './person-list.component.html',
  styleUrls: ['./person-list.component.scss']
})
export class PersonListComponent implements OnInit {

  tableCols: Array<any>;
  persons: Array<IPersonFull>;

  constructor(private userService: UserService,
              private personService: PersonService,
              private router: Router) { }

  ngOnInit() {

    this.tableCols = [
      { field: 'firstName', header: 'Křestní jméno' },
      { field: 'lastName', header: 'Příjmení' },
      { field: 'login', header: 'Login' },
    ];

    this.personService.query().subscribe((persons: HttpResponse<Array<IPersonFull>>) => {
      this.persons = persons.body;
    });
  }

  rowSelect(user: IUser) {
    this.router.navigate(['/admin/users/edit', user.login]);
  }
}
