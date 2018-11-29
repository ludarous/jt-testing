import {Component, OnInit} from '@angular/core';
import {AbstractControl, FormArray, FormControl, FormGroup, Validators} from '@angular/forms';
import {User, IUser} from '../../../../entities/user';
import {ActivatedRoute} from '@angular/router';
import {UserService} from '../../../../services/user.service';
import {Observable, zip} from 'rxjs';
import {catchError, concatMap, map} from 'rxjs/operators';
import {HttpResponse} from '@angular/common/http';
import {RxjsUtils} from '../../../../utils/rxjs.utils';
import {AddressService} from '../../../../services/address.service';
import {PersonalDataService} from '../../../../services/personal-data.service';
import {IActivity} from '../../../../entities/activity';
import {IActivityCategory} from '../../../../entities/activity-category';
import {CustomValidators} from '../../../../shared/validators/custom-validators';
import {Address, IAddress} from '../../../../entities/address';
import {IPersonalData, PersonalData} from '../../../../entities/personal-data';
import {PersonService} from '../../../../services/person.service';
import {IPerson, Person} from '../../../../entities/person';

@Component({
  selector: 'app-edit',
  templateUrl: './users-edit.component.html',
  styleUrls: ['./users-edit.component.scss']
})
export class UsersEditComponent implements OnInit {

  user: IUser;
  userLogin: string;

  person: IPerson;

  addressForm: FormGroup;
  address: IAddress;

  personalDataForm: FormGroup;
  personalData: IPersonalData;

  constructor(private activatedRoute: ActivatedRoute,
              private userService: UserService,
              private addressService: AddressService,
              private personalDataService: PersonalDataService,
              private personService: PersonService) {
  }

  ngOnInit() {

    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.userLogin = params['login'];

      const getUser$ = this.getUser(this.userLogin);

      getUser$
        .subscribe((user: IUser) => {
          this.user = user;

          const getPerson$ = this.getPerson(user.id);
          getPerson$.subscribe((person: IPerson) => {

            this.person = person;

            const getAddress$ = this.getAddress(this.person.addressId);
            getAddress$.subscribe((address: IAddress) => {
              this.address = address;
              this.setAddressForm(this.address);
            });

            const getPersonalData$ = this.getPersonalData(this.person.personalDataId);
            getPersonalData$.subscribe((personalData: IPersonalData) => {
              this.personalData = personalData;
              this.setPersonalDataForm(this.personalData);
            });


          });

        });


    });
  }

  setAddressForm(address: IAddress) {

    this.addressForm = new FormGroup({
      id: new FormControl(address.id),
      country: new FormControl(address.country),
      city: new FormControl(address.city),
      street: new FormControl(address.street),
      zipCode: new FormControl(address.zipCode),
    });
  }

  setPersonalDataForm(personalData: IPersonalData) {

    this.personalDataForm = new FormGroup({
      id: new FormControl(personalData.id),
      firstName: new FormControl(personalData.firstName),
      lastName: new FormControl(personalData.lastName),
      birthDate: new FormControl(personalData.birthDate),
      nationality: new FormControl(personalData.nationality),
    });
  }

  onItemSelect(item: any) {
    console.log(item);
  }

  onSelectAll(items: any) {
    console.log(items);
  }

  saveUser() {

  }


  getUser(userLogin: string): Observable<IUser> {
    if (userLogin) {
      return this.userService.find(userLogin).pipe(map((userResponse: HttpResponse<IUser>) => {
        return userResponse.body;
      }));

    } else {
      return RxjsUtils.create(new User());
    }
  }

  getAddress(addressId: number): Observable<IAddress> {
    if (addressId) {
      return this.addressService.find(addressId).pipe(map((addressResponse: HttpResponse<IAddress>) => {
        return addressResponse.body;
      }));

    } else {
      return RxjsUtils.create(new Address());
    }
  }

  getPersonalData(personalDataId: number): Observable<IPersonalData> {
    if (personalDataId) {
      return this.personalDataService.find(personalDataId).pipe(map((personalDataResponse: HttpResponse<IPersonalData>) => {
        return personalDataResponse.body;
      }));

    } else {
      return RxjsUtils.create(new PersonalData());
    }
  }

  getPerson(userId: number): Observable<IPerson> {
    const getPerson$ = this.personService.findByUserId(userId);
    return getPerson$.pipe(map((personResponse: HttpResponse<IPerson>) => {
        return personResponse.body;
      }),
      catchError((error: any) => {
        return RxjsUtils.create(new Person());
      }));
  }
}
