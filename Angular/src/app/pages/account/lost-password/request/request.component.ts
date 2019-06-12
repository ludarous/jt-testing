import {Component, OnInit} from '@angular/core';
import {AbstractControl, FormControl, FormGroup, Validators} from '@angular/forms';
import {HttpErrorResponse} from '@angular/common/http';
import {AccountService} from '../../../../core/auth/account.service';
import {EventManager} from '../../../../services/event.manager';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-request',
  templateUrl: './request.component.html',
  styleUrls: ['./request.component.scss']
})
export class RequestComponent implements OnInit {

  constructor(private accountService: AccountService,
              private eventManager: EventManager,
              private messageService: MessageService) { }

  public form: AbstractControl;

  ngOnInit() {
    this.form = this.initForm();
  }

  initForm(): FormGroup {
    return new FormGroup({
      mail: new FormControl('', [Validators.compose([Validators.required, Validators.email])])
    });
  }

  onSubmit() {
    this.accountService.resetPasswordInit(this.form.get('mail').value).subscribe(() => {
        this.eventManager.broadcast({
          name: 'resetPasswordInitSuccess',
          content: 'Reset Password Init Success'
        });
      },
      (error: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Nepodařilo se odeslat žádost o nové heslo! Podrobnosti:', detail: error.error.detail});
      });
  }

}
