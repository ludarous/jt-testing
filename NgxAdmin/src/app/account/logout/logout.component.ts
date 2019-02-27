/**
 * @license
 * Copyright Akveo. All Rights Reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 */
import {Component, Inject, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {AuthServerProvider} from '../../@core/auth/auth-jwt.service';

@Component({
  selector: 'ngx-logout',
  templateUrl: './logout.component.html',
})
export class LogoutComponent implements OnInit {

  redirectDelay = 1000;

  constructor(protected router: Router,
              private authProvider: AuthServerProvider) {

  }

  ngOnInit(): void {
    this.logout();
  }

  logout(): void {
    this.authProvider.logout();

    setTimeout(() => {
      return this.router.navigate(['/home']);
    }, this.redirectDelay);

  }

}
