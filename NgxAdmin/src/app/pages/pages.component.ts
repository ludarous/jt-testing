import {Component, OnInit} from '@angular/core';

import {ADMIN_MENU_ITEMS, MENU_ITEMS, PERSON_MENU_ITEMS} from './pages-menu';
import {Principal} from '../@core/auth/principal.service';
import {Authorities, AuthoritiesEnum} from '../entities/enums/authorities';
import {IUser} from "../entities/user";
import {Observable} from "rxjs";
import {IPersonFull, PersonFull} from "../entities/person-full";
import {catchError, map} from "rxjs/operators";
import {HttpErrorResponse, HttpResponse} from "@angular/common/http";
import {RxjsUtils} from "../@core/utils/rxjs.utils";
import {PersonService} from "../services/person.service";
import {AdminComponent} from "./admin/admin.component";

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

  constructor(private principal: Principal,
              private personService: PersonService) {

  }

  currentUser: IUser;
  currentPerson: IPersonFull;

  isAdmin: boolean;
  isPerson: boolean;

  menu = MENU_ITEMS;

  ngOnInit(): void {
    this.principal.hasAuthority(Authorities.ROLE_ADMIN.value).then((hasRole) => {
      this.isAdmin = hasRole;
    });

    this.currentUser = this.principal.getCurrentIdentity();
    this.getPerson(this.currentUser.id).subscribe((person: IPersonFull) => {
      this.currentPerson = person;
      this.isPerson = !!this.currentPerson;

      if(this.isAdmin) {
        this.menu = this.menu.concat(ADMIN_MENU_ITEMS);
      }

      if(this.isPerson) {
        this.menu = this.menu.concat(PERSON_MENU_ITEMS);
      }
    })

  }

  getPerson(userId: number): Observable<IPersonFull> {
    if (userId) {
      return this.personService.findByUserId(userId).pipe(map(
        (personResponse: HttpResponse<IPersonFull>) => {
          return PersonFull.resolveResponse(personResponse);
        }),
        catchError((error: HttpErrorResponse) => {
            return RxjsUtils.create(new PersonFull());
          }
        ));

    } else {
      return RxjsUtils.create(new PersonFull());
    }
  }

}
