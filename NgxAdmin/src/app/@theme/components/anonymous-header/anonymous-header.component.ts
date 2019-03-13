import {Component, Input, OnInit} from '@angular/core';
import {NbMenuService, NbSidebarService} from '@nebular/theme';
import {LayoutService} from '../../../@core/utils';
import {IUser} from '../../../entities/user';
import {Principal} from '../../../@core/auth/principal.service';

@Component({
  selector: 'ngx-anonymous-header',
  styleUrls: ['./anonymous-header.component.scss'],
  templateUrl: './anonymous-header.component.html',
})
export class AnonymousHeaderComponent implements OnInit {

  @Input() position = 'normal';

  constructor(private sidebarService: NbSidebarService,
              private menuService: NbMenuService,
              private layoutService: LayoutService,
              public principal: Principal) {
  }

  ngOnInit() {

  }

  toggleSidebar(): boolean {
    this.sidebarService.toggle(true, 'anonymous-menu-sidebar');
    this.layoutService.changeLayoutSize();

    return false;
  }

  goToHome() {
    this.menuService.navigateHome();
  }

}
