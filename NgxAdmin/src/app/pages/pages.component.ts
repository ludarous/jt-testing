import {Component, OnInit} from '@angular/core';

import { MENU_ITEMS } from './pages-menu';
import {Principal} from '../@core/auth/principal.service';
import {Authorities} from '../entities/enums/authorities';

@Component({
  selector: 'ngx-pages',
  styleUrls: ['pages.component.scss'],
  template: `
    <ngx-sample-layout>
      <nb-menu [items]="menu"></nb-menu>
      <router-outlet></router-outlet>
    </ngx-sample-layout>
  `,
})
export class PagesComponent implements OnInit {

  constructor(private principal: Principal) {

  }

  isAdmin: boolean;
  isPerson: boolean;

  menu = MENU_ITEMS;

  ngOnInit(): void {
    this.principal.hasAuthority(AuthoritiesE);
  }

}
