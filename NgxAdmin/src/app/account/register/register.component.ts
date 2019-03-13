import { Component, OnInit } from '@angular/core';
import {AbstractControl, FormControl, FormGroup, Validators} from '@angular/forms';
import {environment} from '../../../environments/environment';
import {EventManager} from '../../services/event.manager';
import {MessageService} from 'primeng/api';
import {Router} from '@angular/router';
import {AuthServerProvider} from '../../@core/auth/auth-jwt.service';
import {CustomValidators} from '../../@theme/validators/custom-validators';

@Component({
  selector: 'ngx-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {

  showMessages: any = {};
  errors: string[] = [];
  messages: string[] = [];
  public submitted = false;

  public form: FormGroup;

  public login: AbstractControl;
  public email: AbstractControl;
  public password: AbstractControl;
  public confirmPassword: AbstractControl;
  public termsAgreement: AbstractControl;

  env = environment;

  constructor(private authProvider: AuthServerProvider,
              private eventManager: EventManager,
              private messageService: MessageService,
              private router: Router) {

  }

  ngOnInit() {
    this.initForm();
  }

  initForm() {
    this.form = new FormGroup({
      login: new FormControl('', [Validators.compose([Validators.required, Validators.minLength(3), CustomValidators.loginOrEmail])]),
      email: new FormControl('', [Validators.compose([Validators.required, Validators.email])]),
      password: new FormControl('', [Validators.compose([Validators.required, Validators.minLength(4)])]),
      confirmPassword: new FormControl('', [Validators.compose([Validators.required, Validators.minLength(4)])]),
      termsAgreement: new FormControl('', [Validators.required])
    });

    this.login = this.form.controls['login'];
    this.email = this.form.controls['email'];
    this.password = this.form.controls['password'];
    this.confirmPassword = this.form.controls['confirmPassword'];
    this.termsAgreement = this.form.controls['termsAgreement'];
  }

  onSubmit() {
    this.authProvider.register(this.form.value, this.confirmPassword.value).subscribe(() => {
        this.messageService.add({severity: 'success', summary: 'Registrace proběhla v pořádku, nyní se stačí přihlásit.'});
        setTimeout(() => {
          this.router.navigate(['/account/login']);
        }, 1000);
      },
      (error: string) => {
        this.messageService.add({severity: 'error', summary: 'Nepodařilo se registrovat! Podrobnosti:', detail: error});
      });
  }

}
