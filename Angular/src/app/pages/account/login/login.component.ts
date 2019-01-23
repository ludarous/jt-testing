import { Component, OnInit } from '@angular/core';
import {AbstractControl, FormControl, FormGroup, Validators} from '@angular/forms';
import {environment} from '../../../../environments/environment';
import {CustomValidators} from '../../../shared/validators/custom-validators';
import {AuthServerProvider} from '../../../core/auth/auth-jwt.service';
import {EventManager} from '../../../services/event.manager';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {MessageService} from 'primeng/api';

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
              private eventManager: EventManager,
              private messageService: MessageService) {
    this.form = new FormGroup({
      username: new FormControl('', [Validators.compose([Validators.required, Validators.minLength(3), CustomValidators.loginOrEmail])]),
      password: new FormControl('', [Validators.compose([Validators.required, Validators.minLength(4)])]),
      rememberMe: new FormControl(true)
    });

    this.username = this.form.controls['username'];
    this.password = this.form.controls['password'];
  }

  ngOnInit() {

  }

  onSubmit() {
    this.authProvider.login(this.form.value).subscribe(() => {
      this.eventManager.broadcast({
        name: 'authenticationSuccess',
        content: 'Sending Authentication Success'
      });
    },
      (error: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Nepodařilo se přihlásit! Podrobnosti:', detail: error.error.detail});
      });
  }

}
