import { Component, OnInit } from '@angular/core';
import {Principal} from '../../../core/auth/principal.service';
import {EventService} from '../../../services/event.service';
import {User} from '../../../entities/user';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.scss']
})
export class MenuComponent implements OnInit {

  account: User;

  constructor(private principal: Principal,
              private eventService: EventService) { }

  ngOnInit() {

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
