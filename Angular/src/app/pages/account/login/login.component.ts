import { Component, OnInit } from '@angular/core';
import {AbstractControl, FormControl, FormGroup, Validators} from '@angular/forms';
import {environment} from '../../../../environments/environment';
import {CustomValidators} from '../../../shared/validators/custom-validators';
import {AuthServerProvider} from '../../../core/auth/auth-jwt.service';
import {EventService} from '../../../services/event.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  public form: FormGroup;
  public username: AbstractControl;
  public password: AbstractControl;

  public returnUrl: string;
  private submitted = false;

  env = environment;

  constructor(private authProvider: AuthServerProvider,
              private eventService: EventService) {
    this.form = new FormGroup({
      username: new FormControl('', [Validators.compose([Validators.required, Validators.minLength(3), CustomValidators.loginOrEmail])]),
      password: new FormControl('', [Validators.compose([Validators.required, Validators.minLength(4)])])
    });

    this.username = this.form.controls['username'];
    this.password = this.form.controls['password'];
  }

  ngOnInit() {

  }

  onSubmit() {
    this.authProvider.login(this.form.value).subscribe(() => {
      this.eventService.broadcast({
        name: 'authenticationSuccess',
        content: 'Sending Authentication Success'
      });
    });
  }

}
