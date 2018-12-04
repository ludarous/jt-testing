import {Component, OnInit} from '@angular/core';
import {Principal} from '../../../core/auth/principal.service';
import {EventManager} from '../../../services/event.manager';
import {IUser, User} from '../../../entities/user';
import {PersonService} from '../../../services/person.service';
import {IPersonFull} from '../../../entities/person-full';
import {IPerson} from '../../../entities/person';
import {HttpResponse} from '@angular/common/http';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.scss']
})
export class MenuComponent implements OnInit {

  account: User;
  person: IPerson;

  showAdminMenuItem: boolean;


  constructor(private principal: Principal,
              private eventManager: EventManager,
              private personService: PersonService) {
  }

  ngOnInit() {

    this.updateIdentity();
    this.registerAuthenticationSuccess();

  }

  registerAuthenticationSuccess() {
    this.eventManager.subscribe('authenticationSuccess', message => {
      this.updateIdentity(true);
    });
  }

  showUserName(): string {
    if (this.account) {
      if (this.account.firstName || this.account.lastName) {
        return this.account.firstName + ' ' + this.account.lastName;
      } else {
        return this.account.email;
      }
    }
    return 'Neznámý uživatel';
  }

  updateIdentity(force = false) {
    this.principal.identity(force).then(account => {

      if (account) {
        this.account = account;

        this.principal.hasAnyAuthority(['ROLE_ADMIN']).then((value) => {
          this.showAdminMenuItem = value;
        });

        this.personService.findByUserId(this.account.id).subscribe((person: HttpResponse<IPerson>) => {
            this.person = person.body;
          },
          (error: HttpResponse<any>) => {
            this.person = null;
          });
      }

    });
  }


}
