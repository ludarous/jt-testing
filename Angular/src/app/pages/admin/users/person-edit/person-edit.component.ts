import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup} from '@angular/forms';
import {ActivatedRoute} from '@angular/router';
import {UserService} from '../../../../services/user.service';
import {Observable} from 'rxjs';
import {map} from 'rxjs/operators';
import {HttpResponse} from '@angular/common/http';
import {RxjsUtils} from '../../../../utils/rxjs.utils';
import {AddressService} from '../../../../services/address.service';
import {PersonalDataService} from '../../../../services/personal-data.service';
import {Address, IAddress} from '../../../../entities/address';
import {IPersonalData, PersonalData} from '../../../../entities/personal-data';
import {PersonService} from '../../../../services/person.service';
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
      virtual: new FormControl(person.virtual)
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

      const personToSave = this.personForm.value;

      let savePerson$;
      if (personToSave.id) {
        savePerson$ = this.personService.updateFull(personToSave);
      } else {
        savePerson$ = this.personService.saveFull(personToSave);
      }

      savePerson$.subscribe((personResponse: HttpResponse<PersonFull>) => {
        this.person = personResponse.body;
      });
    }
  }

  duplicatePerson() {
    this.personForm.controls['id'].setValue(null);
    const personalDataForm = <FormGroup>this.personForm.controls['personalData'];
    const addressForm = <FormGroup>this.personForm.controls['address'];

    personalDataForm.controls['id'].setValue(null);
    addressForm.controls['id'].setValue(null);
    this.savePerson();
  }

}
