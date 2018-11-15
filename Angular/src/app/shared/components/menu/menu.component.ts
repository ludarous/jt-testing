import { Component, OnInit } from '@angular/core';
import {Principal} from '../../../core/auth/principal.service';
import {EventManager} from '../../../services/event.manager';
import {User} from '../../../entities/user';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.scss']
})
export class MenuComponent implements OnInit {

  account: User;

  constructor(private principal: Principal,
              private eventManager: EventManager) { }

  ngOnInit() {

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
