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
        label: 'Aktivity',
        routerLink: ['/admin/activities'],
        routerLinkActiveOptions: {exact: true},
        items: [
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
            label: 'Kategorie testů',
            routerLink: ['/admin/test-categories'],
            routerLinkActiveOptions: {exact: true},
            items: [
              {
                label: 'Seznam kategorie testů',
                routerLink: ['/admin/test-categories/list'],
                routerLinkActiveOptions: {exact: true},
              },
              {
                label: 'Vytvoř kategorii testu',
                routerLink: ['/admin/test-categories/create'],
                routerLinkActiveOptions: {exact: true},
              }
            ]
          },
          {
            label: 'Seznam testů',
            routerLink: ['/admin/tests/list'],
            routerLinkActiveOptions: {exact: true},
          },
          {
            label: 'Vytvoř test',
            routerLink: ['/admin/tests/create'],
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
            label: 'Seznam událostí',
            routerLink: ['/admin/events/list'],
            routerLinkActiveOptions: {exact: true},
          },
          {
            label: 'Vytvoř událost',
            routerLink: ['/admin/events/create'],
            routerLinkActiveOptions: {exact: true},
          }
        ]
      },
      {
        label: 'Uživatelé',
        routerLink: ['/admin/users'],
        routerLinkActiveOptions: {exact: true},
        items: [
          {
            label: 'Seznam uživatelů',
            routerLink: ['/admin/users/list'],
            routerLinkActiveOptions: {exact: true},
          },
          {
            label: 'Vytvoř uživatele',
            routerLink: ['/admin/users/create'],
            routerLinkActiveOptions: {exact: true},
          }
        ]
      },
      {
        label: 'Výsledky',
        routerLink: ['/admin/results'],
        routerLinkActiveOptions: {exact: true},
      },
    ];
  }

}
