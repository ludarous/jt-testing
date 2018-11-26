import {Component, Input, OnInit} from '@angular/core';
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
import {IPersonFull, PersonFull} from '../../../../entities/person-full';

@Component({
  selector: 'app-person-edit',
  templateUrl: './person-edit.component.html',
  styleUrls: ['./person-edit.component.scss']
})
export class PersonEditComponent implements OnInit {

  personId: number;
  person: IPersonFull;
  personForm: FormGroup;

  constructor(private activatedRoute: ActivatedRoute,
              private userService: UserService,
              private addressService: AddressService,
              private personalDataService: PersonalDataService,
              private personService: PersonService) {
  }

  ngOnInit() {
    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.personId = params['id'];

      const getPerson$ = this.getPerson(this.personId);
      getPerson$
        .subscribe((person: IPersonFull) => {
          this.person = person;
          this.setPersonForm(this.person);
        });
    });

  }

  setPersonForm(person: IPersonFull) {
    this.personForm = new FormGroup({
      id: new FormControl(person.id),
      email: new FormControl(person.email),
    });

    if (!person.address) person.address = new Address();
    this.personForm.addControl('address', this.setAddressForm(person.address));

    if (!person.personalData) person.personalData = new PersonalData();
    this.personForm.addControl('personalData', this.setPersonalDataForm(person.personalData));
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
      birthDate: new FormControl(personalData.birthDate),
      nationality: new FormControl(personalData.nationality),
    });
  }

  getPerson(personId: number): Observable<IPersonFull> {
    if (personId) {
      return this.personService.findFull(personId).pipe(map((personResponse: HttpResponse<IPersonFull>) => {
        return personResponse.body;
      }));

    } else {
      return RxjsUtils.create(new PersonFull());
    }
  }

  savePerson() {
    if (this.personForm.valid) {

      const personalDataFormGroup = <FormGroup>this.personForm.controls['personalData'];
      const date = new Date();
      personalDataFormGroup.controls['birthDate'].setValue(date.toISOString());

      const personToSave = this.personForm.value;
      this.personService.saveFull(personToSave).subscribe((personResponse: HttpResponse<PersonFull>) => {
        this.person = personResponse.body;
      });
    }
  }

}