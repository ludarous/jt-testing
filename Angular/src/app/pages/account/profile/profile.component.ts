import {Component, OnInit} from '@angular/core';
import {IPersonFull, PersonFull} from '../../../entities/person-full';
import {FormControl, FormGroup} from '@angular/forms';
import {ActivatedRoute, Router} from '@angular/router';
import {UserService} from '../../../services/user.service';
import {AddressService} from '../../../services/address.service';
import {PersonalDataService} from '../../../services/personal-data.service';
import {PersonService} from '../../../services/person.service';
import {MessageService, SelectItem} from 'primeng/api';
import {Address, IAddress} from '../../../entities/address';
import {IPersonalData, PersonalData} from '../../../entities/personal-data';
import {Observable} from 'rxjs';
import {catchError, map} from 'rxjs/operators';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {RxjsUtils} from '../../../utils/rxjs.utils';
import {Principal} from '../../../core/auth/principal.service';
import {IPerson} from '../../../entities/person';
import {IUser, User} from '../../../entities/user';
import {EventManager} from '../../../services/event.manager';
import {ActivityResultUnits} from '../../../entities/enums/activity-result-units';
import {Sex} from '../../../entities/enums/sex';
import {ResultType} from '../../../entities/enums/result-type';
import {EnumTranslatorService} from '../../../shared/pipes/enum-translator/enum-translator';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {

  account: IUser;

  person: IPersonFull;
  personForm: FormGroup;

  sexes: Array<Sex>;
  sexOptions: Array<SelectItem>;

  private _personBirthDate: Date;
  get personBirthDate(): Date {
    return this._personBirthDate;
  }

  set personBirthDate(value: Date) {
    this._personBirthDate = value;
    if (this.personForm && value) {
      (<FormGroup>this.personForm.controls['personalData']).controls['birthDate'].setValue(value.toISOString());
    }
  }


  constructor(private activatedRoute: ActivatedRoute,
              private userService: UserService,
              private principal: Principal,
              private addressService: AddressService,
              private personalDataService: PersonalDataService,
              private personService: PersonService,
              private messageService: MessageService,
              private eventManager: EventManager,
              private router: Router,
              private enumTranslateService: EnumTranslatorService) {
  }

  ngOnInit() {

    this.sexes = Sex.getAll();
    this.sexOptions = this.sexes.map(s => ({label: this.enumTranslateService.translate(s), value: s.ordinal}));

    this.principal.identity().then((account) => {
      this.account = account;

      this.getPerson(account.id).subscribe((person: IPersonFull) => {
          this.person = person;
          this.setPersonForm(this.person);
        },
        (errorResponse: HttpErrorResponse) => {
          this.person = null;
        });
    });
  }

  setPersonForm(person: IPersonFull) {
    this.personForm = new FormGroup({
      id: new FormControl(person.id),
      email: new FormControl(this.account.email),
      virtual: new FormControl(person.virtual ? person.virtual : false)
    });

    if (!person.address) person.address = new Address();
    this.personForm.addControl('address', this.setAddressForm(person.address));

    if (!person.personalData) person.personalData = new PersonalData();
    this.personForm.addControl('personalData', this.setPersonalDataForm(person.personalData));

    this.personBirthDate = person.personalData.birthDate ? new Date(person.personalData.birthDate) : null;
  }

  setAddressForm(address: IAddress) {

    return new FormGroup({
      id: new FormControl(address.id),
      country: new FormControl(address.country),
      city: new FormControl(address.city),
      street: new FormControl(address.street),
      zipCode: new FormControl(address.zipCode),
    });
  }

  setPersonalDataForm(personalData: IPersonalData) {

    return new FormGroup({
      id: new FormControl(personalData.id),
      firstName: new FormControl(personalData.firstName),
      lastName: new FormControl(personalData.lastName),
      birthDate: new FormControl(personalData.birthDate ? new Date(personalData.birthDate) : null),
      sex: new FormControl(personalData.sex ? personalData.sex.ordinal : null),
      nationality: new FormControl(personalData.nationality),
    });
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

  savePerson() {
    if (this.personForm.valid) {


      const personToSave = this.personForm.value;
      personToSave.user = this.account;

      let savePerson$;
      if (personToSave.id) {
        savePerson$ = this.personService.updateFull(personToSave);
      } else {
        savePerson$ = this.personService.saveFull(personToSave);
      }

      savePerson$.subscribe(
        (personResponse: HttpResponse<PersonFull>) => {
          this.person = personResponse.body;
          this.messageService.add({severity: 'success', summary: 'Profil uložen'});
          this.eventManager.broadcast({
            name: 'profileFilled',
            content: 'Profile successfully filled'
          });
        },
        (errorResponse: HttpErrorResponse) => {
          this.messageService.add({severity: 'error', summary: 'Profil nebyl uložen', detail: errorResponse.error.detail});
        });
    }
  }

}
