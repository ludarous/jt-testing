import {Component, OnInit} from '@angular/core';
import {Principal} from '../../../core/auth/principal.service';
import {EventManager} from '../../../services/event.manager';
import {IUser, User} from '../../../entities/user';
import {PersonService} from '../../../services/person.service';
import {IPersonFull} from '../../../entities/person-full';
import {IPerson} from '../../../entities/person';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {AuthServerProvider} from '../../../core/auth/auth-jwt.service';
import {Router} from '@angular/router';

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
              private personService: PersonService,
              private authProvider: AuthServerProvider,
              private router: Router) {
  }

  ngOnInit() {

    this.updateIdentity();
    this.registerAuthenticationSuccess();
    this.principal.getAuthenticationState().subscribe((account) => {
      this.updateAccount(account);
    });

  }

  registerAuthenticationSuccess() {
    this.eventManager.subscribe('authenticationSuccess', message => {
      this.updateIdentity(true);
    });
  }

  logout() {
    this.authProvider.logout().subscribe();
    this.principal.authenticate(null);
  }

  login() {
    this.router.navigate(['/account/login']);
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
     this.updateAccount(account);
    });
  }

  updateAccount(account: IUser) {
    if (account) {
      this.account = account;

      this.principal.hasAnyAuthority(['ROLE_ADMIN']).then((value) => {
        if (value) {
          this.showAdminMenuItem = value;
          if (this.router.url.includes('/account/login')) this.router.navigate(['/admin']);
        } else {
          if (this.router.url.includes('/account/login')) this.router.navigate(['/user/dashboard']);
        }
      });

      this.personService.findByUserId(this.account.id).subscribe((person: HttpResponse<IPerson>) => {
          this.person = person.body;
        },
        (errorResponse: HttpErrorResponse) => {
          this.person = null;
        });
    } else {
      this.showAdminMenuItem = false;
      this.account = null;
      this.person = null;
      this.router.navigate(['/account/login']);
    }
  }


}
