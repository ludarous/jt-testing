import {Component, OnInit} from '@angular/core';
import {UserService} from './services/user.service';
import {Principal} from './core/auth/principal.service';
import {EventService} from './services/event.service';
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
              private eventService: EventService) {

  }

  account: Account;
  title = 'Angular';

  ngOnInit(): void {

    this.authProvider.login({username: 'admin', password: 'admin', rememberMe: true}).subscribe(result => {
      this.eventService.broadcast({
        name: 'authenticationSuccess',
        content: 'Sending Authentication Success'
      });
    });

    this.principal.identity().then(account => {
      this.account = account;
    });

    this.registerAuthenticationSuccess();
  }

  registerAuthenticationSuccess() {
    this.eventService.subscribe('authenticationSuccess', message => {
      this.principal.identity().then(account => {
        this.account = account;
      });
    });
  }
}
