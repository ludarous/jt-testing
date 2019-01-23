import { Component, OnInit } from '@angular/core';
import {AbstractControl, FormControl, FormGroup, Validators} from '@angular/forms';
import {environment} from '../../../../environments/environment';
import {AuthServerProvider} from '../../../core/auth/auth-jwt.service';
import {EventManager} from '../../../services/event.manager';
import {MessageService} from 'primeng/api';
import {CustomValidators} from '../../../shared/validators/custom-validators';
import {HttpErrorResponse} from '@angular/common/http';
import {Router} from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {

  public form: FormGroup;
  public confirmPassword: string;

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
      password: new FormControl('', [Validators.compose([Validators.required, Validators.minLength(4)])])
    });
  }

  onSubmit() {
    this.authProvider.register(this.form.value, this.confirmPassword).subscribe(() => {
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
