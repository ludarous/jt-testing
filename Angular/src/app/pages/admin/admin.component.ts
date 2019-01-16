import {Component, OnInit, ViewEncapsulation} from '@angular/core';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class AdminComponent implements OnInit {

  constructor() { }

  menuItems: Array<any>;

  ngOnInit() {
    this.menuItems = [
      {
        label: 'Kategorie aktivit',
        routerLink: ['/admin/activity-categories'],
        routerLinkActiveOptions: {exact: true},
        items: [
          {
            label: 'Seznam kategorie aktivit',
            routerLink: ['/admin/activity-categories/list'],
            routerLinkActiveOptions: {exact: true},
          },
          {
            label: 'Vytvoř kategorii',
            routerLink: ['/admin/activity-categories/create'],
            routerLinkActiveOptions: {exact: true},
          }
        ]
      },
      {
        label: 'Aktivity',
        routerLink: ['/admin/activities'],
        routerLinkActiveOptions: {exact: true},
        items: [
          {
            label: 'Seznam aktivity',
            routerLink: ['/admin/activities/list'],
            routerLinkActiveOptions: {exact: true},
          },
          {
            label: 'Vytvoř aktivitu',
            routerLink: ['/admin/activities/create'],
            routerLinkActiveOptions: {exact: true},
          }
        ]
      },
      {
        label: 'Testy',
        routerLink: ['/admin/tests'],
        routerLinkActiveOptions: {exact: true},
        items: [
          {
            label: 'Seznam testů',
            routerLink: ['/admin/tests/list'],
            routerLinkActiveOptions: {exact: true},
          },
          {
            label: 'Vytvoř test',
            routerLink: ['/admin/tests/create'],
            routerLinkActiveOptions: {exact: true},
          },
          {
            label: 'Ketegorie',
            routerLink: ['/admin/tests/categories'],
            routerLinkActiveOptions: {exact: true},
          }
        ]
      },
      {
        label: 'Události',
        routerLink: ['/admin/events'],
        routerLinkActiveOptions: {exact: true},
        items: [
          {
            label: 'Seznam aktivity',
            routerLink: ['/admin/events/list'],
            routerLinkActiveOptions: {exact: true},
          },
          {
            label: 'Vytvoř aktivitu',
            routerLink: ['/admin/events/create'],
            routerLinkActiveOptions: {exact: true},
          }
        ]
      },
    ];
  }

}
