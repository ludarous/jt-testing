import { Component, OnInit } from '@angular/core';
import {AbstractControl, FormControl, FormGroup, Validators} from '@angular/forms';
import {environment} from '../../../environments/environment';
import {EventManager} from '../../services/event.manager';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {MessageService} from 'primeng/api';
import {AuthServerProvider} from '../../@core/auth/auth-jwt.service';
import {CustomValidators} from '../../@theme/validators/custom-validators';
import {Router} from '@angular/router';
import {TranslateService} from '@ngx-translate/core';

@Component({
  selector: 'ngx-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  showMessages: any = {};
  errors: string[] = [];
  messages: string[] = [];

  public form: FormGroup;
  public username: AbstractControl;
  public password: AbstractControl;
  public rememberMe: AbstractControl;

  public returnUrl: string;
  public submitted = false;

  env = environment;

  constructor(private authProvider: AuthServerProvider,
              private eventManager: EventManager,
              private messageService: MessageService,
              private translateService: TranslateService,
              private router: Router) {
    this.form = new FormGroup({
      username: new FormControl('', [Validators.compose([Validators.required, Validators.minLength(3), CustomValidators.loginOrEmail])]),
      password: new FormControl('', [Validators.compose([Validators.required, Validators.minLength(4)])]),
      rememberMe: new FormControl(true)
    });

    this.username = this.form.controls['username'];
    this.password = this.form.controls['password'];
    this.rememberMe = this.form.controls['rememberMe'];
  }

  ngOnInit() {

  }

  onSubmit() {
    this.authProvider.login(this.form.value).subscribe(
      () => {
      this.router.navigate(['/pages/dashboard']);
      this.eventManager.broadcast({
        name: 'authenticationSuccess',
        content: 'Sending Authentication Success'
      });
    },
      (errorResponse: HttpErrorResponse) => {
        this.showMessages.error = true;
        let message = this.translateService.instant('Nepodařilo se přihlásit!');
        if (errorResponse.error.detail === 'Bad credentials!') {
          message += ' ';
          message += this.translateService.instant('Špatné přihlašovací údaje!');
        }
        this.errors.push(message);
      });
  }

}
