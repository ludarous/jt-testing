/**
 * @license
 * Copyright Akveo. All Rights Reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 */
import {Component, OnDestroy} from '@angular/core';
import {Location} from '@angular/common';


@Component({
  selector: 'ngx-account',
  styleUrls: ['./account.component.scss'],
  template: `
    <nb-layout>
      <nb-layout-column>
        <nb-card>
          <nb-card-header>
            <nav class="navigation">
              <a href="#" (click)="back()" class="link" aria-label="Back"><i class="icon nb-arrow-thin-left"></i></a>
            </nav>
          </nb-card-header>
          <nb-card-body>
            <nb-auth-block>
              <router-outlet></router-outlet>
            </nb-auth-block>
          </nb-card-body>
        </nb-card>
      </nb-layout-column>
    </nb-layout>
  `,
})
export class AccountComponent implements OnDestroy {

  private alive = true;

  subscription: any;

  // showcase of how to use the onAuthenticationChange method
  constructor(protected location: Location) {

  }

  back() {
    this.location.back();
    return false;
  }

  ngOnDestroy(): void {
    this.alive = false;
  }
}
