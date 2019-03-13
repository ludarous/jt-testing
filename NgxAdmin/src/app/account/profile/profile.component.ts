import {Component, OnInit} from '@angular/core';
import {AbstractControl, FormControl, FormGroup} from '@angular/forms';
import {ActivatedRoute, Router} from '@angular/router';
import {Observable} from 'rxjs';
import {catchError, map} from 'rxjs/operators';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {IUser} from '../../entities/user';
import {IPersonFull, PersonFull} from '../../entities/person-full';
import {Sex} from '../../entities/enums/sex';
import {MessageService, SelectItem} from 'primeng/api';
import {UserService} from '../../services/user.service';
import {Principal} from '../../@core/auth/principal.service';
import {PersonalDataService} from '../../services/personal-data.service';
import {AddressService} from '../../services/address.service';
import {PersonService} from '../../services/person.service';
import {EventManager} from '../../services/event.manager';
import {EnumTranslatorService} from '../../@theme/modules/enum-translator/enum-translator';
import {Address, IAddress} from '../../entities/address';
import {IPersonalData, PersonalData} from '../../entities/personal-data';
import {RxjsUtils} from '../../@core/utils/rxjs.utils';
import * as moment from 'moment';
import {Moment} from 'moment';
import {NbToastrService} from '@nebular/theme';
import {ToastUtils} from '../../@core/utils/toast.utils';
import {NbToastStatus} from '@nebular/theme/components/toastr/model';


@Component({
  selector: 'ngx-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {

  showMessages: any = {};
  errors: string[] = [];
  messages: string[] = [];
  submitted = false;

  account: IUser;
  person: IPersonFull;
  personForm: FormGroup;

  sexes: Array<Sex>;
  sexOptions: Array<SelectItem>;

  birthDateMoment: Moment;

  email: AbstractControl;
  firstName: AbstractControl;
  lastName: AbstractControl;
  birthDate: AbstractControl;
  sex: AbstractControl;
  nationality: AbstractControl;
  country: AbstractControl;
  city: AbstractControl;
  street: AbstractControl;
  zipCode: AbstractControl;

  private _personBirthDate: Date = new Date();
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
              private enumTranslateService: EnumTranslatorService,
              private toasterService: NbToastrService) {
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

    this.email = this.personForm.controls['email'];

  }

  setAddressForm(address: IAddress) {

    const addressForm = new FormGroup({
      id: new FormControl(address.id),
      country: new FormControl(address.country),
      city: new FormControl(address.city),
      street: new FormControl(address.street),
      zipCode: new FormControl(address.zipCode),
    });

    this.country = addressForm.controls['country'];
    this.city = addressForm.controls['city'];
    this.street = addressForm.controls['street'];
    this.zipCode = addressForm.controls['zipCode'];

    return addressForm;
  }

  setPersonalDataForm(personalData: IPersonalData) {

    const personalDataForm = new FormGroup({
      id: new FormControl(personalData.id),
      firstName: new FormControl(personalData.firstName),
      lastName: new FormControl(personalData.lastName),
      birthDate: new FormControl(personalData.birthDate),
      sex: new FormControl(personalData.sex ? personalData.sex.ordinal : null),
      nationality: new FormControl(personalData.nationality),
    });

    this.firstName = personalDataForm.controls['firstName'];
    this.lastName = personalDataForm.controls['lastName'];
    this.birthDate = personalDataForm.controls['birthDate'];
    this.sex = personalDataForm.controls['sex'];
    this.nationality = personalDataForm.controls['nationality'];

    return personalDataForm;
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


      const personToSave = <IPersonFull>this.personForm.value;
      personToSave.user = this.account;
      personToSave.personalData.birthDate = this.personBirthDate.toISOString();

      let savePerson$;
      if (personToSave.id) {
        savePerson$ = this.personService.updateFull(personToSave);
      } else {
        savePerson$ = this.personService.saveFull(personToSave);
      }

      savePerson$.subscribe(
        (personResponse: HttpResponse<PersonFull>) => {
          this.person = personResponse.body;
          this.toasterService.success(null, 'Profil uložen');
          this.eventManager.broadcast({
            name: 'profileFilled',
            content: 'Profile successfully filled'
          });
        },
        (errorResponse: HttpErrorResponse) => {
          this.toasterService.danger(null, 'Profil nebyl uložen');
        });
    }
  }

  birthDayChange(birthDate: Date) {
    this.personBirthDate = birthDate;
  }

}
