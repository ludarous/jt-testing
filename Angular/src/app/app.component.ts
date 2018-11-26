import {Component, OnInit} from '@angular/core';
import {UserService} from './services/user.service';
import {Principal} from './core/auth/principal.service';
import {EventManager} from './services/event.manager';
import {AuthServerProvider} from './core/auth/auth-jwt.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {

  constructor(private authProvider: AuthServerProvider,
              private principal: Principal,
              private userService: UserService,
              private eventManager: EventManager) {

  }

  account: Account;
  title = 'Angular';

  ngOnInit(): void {

    this.principal.identity().then(account => {
      this.account = account;
    });

    this.registerAuthenticationSuccess();
  }

  registerAuthenticationSuccess() {
    this.eventManager.subscribe('authenticationSuccess', message => {
      this.principal.identity().then(account => {
        this.account = account;
      });
    });
  }
}
