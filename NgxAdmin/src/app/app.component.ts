/**
 * @license
 * Copyright Akveo. All Rights Reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 */
import { Component, OnInit } from '@angular/core';
import { AnalyticsService } from './@core/utils/analytics.service';
import {Principal} from './@core/auth/principal.service';
import {IUser} from './entities/user';
import {Router} from '@angular/router';

@Component({
  selector: 'ngx-app',
  template: '<router-outlet></router-outlet>',
})
export class AppComponent implements OnInit {

  constructor(private analytics: AnalyticsService,
              private principal: Principal,
              private router: Router) {
  }

  ngOnInit(): void {
    this.analytics.trackPageViews();

    this.principal.identity().then((account: IUser) => {
    });
  }
}
