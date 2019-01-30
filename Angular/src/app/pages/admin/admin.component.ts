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
        label: 'Skupiny aktivit',
        routerLink: ['/admin/activity-groups'],
        routerLinkActiveOptions: {exact: true},
        items: [
          {
            label: 'Kategorie skupin aktivit',
            routerLink: ['/admin/activity-group-categories'],
            routerLinkActiveOptions: {exact: true},
            items: [
              {
                label: 'Seznam kategorií skupin aktivit',
                routerLink: ['/admin/activity-group-categories/list'],
                routerLinkActiveOptions: {exact: true},
              },
              {
                label: 'Vytvoř kategorii skupin aktivit',
                routerLink: ['/admin/activity-group-categories/create'],
                routerLinkActiveOptions: {exact: true},
              }
            ]
          },
          {
            label: 'Seznam skupin aktivit',
            routerLink: ['/admin/activity-groups/list'],
            routerLinkActiveOptions: {exact: true},
          },
          {
            label: 'Vytvoř skupinu aktivit',
            routerLink: ['/admin/activity-groups/create'],
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
