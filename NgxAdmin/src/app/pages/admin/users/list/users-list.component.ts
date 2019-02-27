import {Component, OnInit} from '@angular/core';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {Router} from '@angular/router';
import {UserService} from '../../../../services/user.service';
import {PersonService} from '../../../../services/person.service';
import {IPersonFull} from '../../../../entities/person-full';
import {IEvent} from '../../../../entities/event';
import {EventService} from '../../../../services/event.service';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-users-list',
  templateUrl: './users-list.component.html',
  styleUrls: ['./users-list.component.scss']
})
export class UsersListComponent implements OnInit {

  persons: Array<IPersonFull>;
  tablePersons: Array<any>;
  tableCols: Array<any>;

  constructor(private userService: UserService,
              private personService: PersonService,
              private eventService: EventService,
              private messageService: MessageService,
              private router: Router) {
  }

  ngOnInit() {

    this.load();

    this.tableCols = [
      { field: 'firstName', header: 'Křestní jméno' },
      { field: 'lastName', header: 'Příjmení' },
    ];
  }

  load() {
    this.personService.queryFull({
      page: 0,
      size: 1000,
    }).subscribe((personsResponse: HttpResponse<Array<IPersonFull>>) => {
      this.persons = personsResponse.body;
      this.tablePersons = this.persons.map(p => {
          return {
            id: p.id,
            firstName: p.personalData.firstName,
            lastName: p.personalData.lastName
          };
        }
      )
    });
  }

  rowSelect(event: IEvent) {
    this.router.navigate(['/pages/admin/users/edit', event.id]);
  }

  delete(event: IEvent) {
    if (confirm('Opravdu chceš smazat událost ' + event.name)) {
      this.eventService.delete(event.id).subscribe(() => {
        this.load();
      }, (errorResponse: HttpErrorResponse) => {
        this.messageService.add({
          severity: 'error',
          summary: 'Událost se nepodařilo smazat',
          detail: errorResponse.error.detail
        });
      });
    }
  }

  create() {
    this.router.navigate(['/pages/admin/users/create']);
  }
}
