import {Component, Input, OnInit} from '@angular/core';

import {NbMenuService, NbSidebarService} from '@nebular/theme';
import {UserData} from '../../../@core/data/users';
import {AnalyticsService} from '../../../@core/utils';
import {LayoutService} from '../../../@core/utils';
import {Principal} from '../../../@core/auth/principal.service';
import {IUser} from '../../../entities/user';

@Component({
  selector: 'ngx-header',
  styleUrls: ['./header.component.scss'],
  templateUrl: './header.component.html',
})
export class HeaderComponent implements OnInit {

  @Input() position = 'normal';

  userMenu = [
    {
      title: 'Profile',
      link: ['/account/profile']
    }, {
      title: 'Log out',
      link: ['/account/logout']
    }];

  constructor(private sidebarService: NbSidebarService,
              private menuService: NbMenuService,
              public principal: Principal,
              private analyticsService: AnalyticsService,
              private layoutService: LayoutService) {
  }

  ngOnInit() {
      const currentId = this.principal.getCurrentIdentity();
  }

  toggleSidebar(): boolean {
    this.sidebarService.toggle(true, 'menu-sidebar');
    this.layoutService.changeLayoutSize();

    return false;
  }

  goToHome() {
    this.menuService.navigateHome();
  }

  startSearch() {
    this.analyticsService.trackEvent('startSearch');
  }
}
